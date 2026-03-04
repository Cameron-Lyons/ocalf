type phase = Compile | Run | Check
type process_exit = Exited of int | Signaled of int | Stopped of int | Timeout

type diagnostic = {
  phase : phase;
  command : string list;
  exit : process_exit;
  stdout : string;
  stderr : string;
}

type success =
  | CompileAndRunSuccess of {
      compile_stdout : string;
      compile_stderr : string;
      run_stdout : string;
      run_stderr : string;
    }
  | CommandSuccess of { command : string list; stdout : string; stderr : string }

type result =
  | Success of success
  | CompileError of diagnostic
  | RuntimeError of diagnostic

type process_result = { exit : process_exit; stdout : string; stderr : string }

let phase_to_string = function
  | Compile -> "compile"
  | Run -> "run"
  | Check -> "check"

let process_exit_to_string = function
  | Exited code -> Printf.sprintf "exited(%d)" code
  | Signaled signal -> Printf.sprintf "signaled(%d)" signal
  | Stopped signal -> Printf.sprintf "stopped(%d)" signal
  | Timeout -> "timeout"

let result_kind_for_progress = function
  | Success _ -> Progress.Success
  | CompileError _ -> Progress.CompileError
  | RuntimeError _ -> Progress.RuntimeError

let read_file path =
  try
    let ic = open_in path in
    let len = in_channel_length ic in
    let content = really_input_string ic len in
    close_in ic;
    Sys.remove path;
    content
  with _ -> ""

let run_process ~cwd ~prog ~args ~timeout_s =
  let stdout_file = Filename.temp_file "ocalf" "stdout" in
  let stderr_file = Filename.temp_file "ocalf" "stderr" in
  let stdout_fd =
    Unix.openfile stdout_file
      [ Unix.O_CREAT; Unix.O_TRUNC; Unix.O_WRONLY ]
      0o600
  in
  let stderr_fd =
    Unix.openfile stderr_file
      [ Unix.O_CREAT; Unix.O_TRUNC; Unix.O_WRONLY ]
      0o600
  in
  let argv = Array.of_list (prog :: args) in
  let pid =
    try
      match Unix.fork () with
      | 0 ->
          (try
             (match cwd with None -> () | Some dir -> Unix.chdir dir);
             Unix.dup2 stdout_fd Unix.stdout;
             Unix.dup2 stderr_fd Unix.stderr;
             Unix.close stdout_fd;
             Unix.close stderr_fd;
             Unix.execvp prog argv
           with exn ->
             let msg =
               Printf.sprintf "failed to exec '%s': %s\n" prog
                 (Printexc.to_string exn)
             in
             let _ =
               Unix.write_substring Unix.stderr msg 0 (String.length msg)
             in
             exit 127)
      | child_pid -> child_pid
    with exn ->
      Unix.close stdout_fd;
      Unix.close stderr_fd;
      let stderr =
        Printf.sprintf "failed to spawn '%s': %s" prog (Printexc.to_string exn)
      in
      let _ = Sys.remove stdout_file in
      let _ = Sys.remove stderr_file in
      raise (Failure stderr)
  in
  Unix.close stdout_fd;
  Unix.close stderr_fd;
  let start = Unix.gettimeofday () in
  let rec wait_for_exit () =
    match Unix.waitpid [ Unix.WNOHANG ] pid with
    | 0, _ ->
        if Unix.gettimeofday () -. start > timeout_s then (
          (try Unix.kill pid Sys.sigkill with _ -> ());
          let _ = Unix.waitpid [] pid in
          Timeout)
        else (
          Unix.sleepf 0.05;
          wait_for_exit ())
    | _, Unix.WEXITED code -> Exited code
    | _, Unix.WSIGNALED signal -> Signaled signal
    | _, Unix.WSTOPPED signal -> Stopped signal
  in
  let exit = wait_for_exit () in
  let stdout = read_file stdout_file in
  let stderr = read_file stderr_file in
  { exit; stdout; stderr }

let verify_compile_and_run path =
  let tmp_dir = Filename.temp_file "ocalf" "tmp" in
  Sys.remove tmp_dir;
  Unix.mkdir tmp_dir 0o755;
  let exe_path = Filename.concat tmp_dir "exercise" in
  let cleanup () =
    if Sys.file_exists tmp_dir then FileUtil.rm ~recurse:true [ tmp_dir ]
  in
  let compile =
    try
      run_process ~prog:"ocamlfind"
        ~cwd:None
        ~args:
          [ "ocamlopt"; "-package"; "str"; "-linkpkg"; "-o"; exe_path; path ]
        ~timeout_s:20.0
    with Failure stderr -> { exit = Exited 127; stdout = ""; stderr }
  in
  match compile.exit with
  | Exited 0 -> (
      let run =
        try run_process ~cwd:None ~prog:exe_path ~args:[] ~timeout_s:5.0
        with Failure stderr -> { exit = Exited 127; stdout = ""; stderr }
      in
      cleanup ();
      match run.exit with
      | Exited 0 ->
          Success
            (CompileAndRunSuccess
               {
                 compile_stdout = compile.stdout;
                 compile_stderr = compile.stderr;
                 run_stdout = run.stdout;
                 run_stderr = run.stderr;
               })
      | _ ->
          RuntimeError
            {
              phase = Run;
              command = [ exe_path ];
              exit = run.exit;
              stdout = run.stdout;
              stderr = run.stderr;
            })
  | _ ->
      cleanup ();
      CompileError
        {
          phase = Compile;
          command =
            [
              "ocamlfind";
              "ocamlopt";
              "-package";
              "str";
              "-linkpkg";
              "-o";
              exe_path;
              path;
            ];
          exit = compile.exit;
          stdout = compile.stdout;
          stderr = compile.stderr;
        }

let substitute_tokens ~project_root ~exercise_id ~exercise_path value =
  value
  |> Str.global_replace (Str.regexp_string "{project_root}") project_root
  |> Str.global_replace (Str.regexp_string "{exercise_id}") exercise_id
  |> Str.global_replace (Str.regexp_string "{exercise_path}") exercise_path

let verify_custom_command ~project_root ~exercise_id ~exercise_path argv =
  let expanded =
    List.map
      (substitute_tokens ~project_root ~exercise_id ~exercise_path)
      argv
  in
  match expanded with
  | [] ->
      CompileError
        {
          phase = Check;
          command = [];
          exit = Exited 2;
          stdout = "";
          stderr = "check_command cannot be empty";
        }
  | prog :: args -> (
      let run =
        try
          run_process ~cwd:(Some project_root) ~prog ~args ~timeout_s:20.0
        with Failure stderr -> { exit = Exited 127; stdout = ""; stderr }
      in
      match run.exit with
      | Exited 0 ->
          Success
            (CommandSuccess
               { command = expanded; stdout = run.stdout; stderr = run.stderr })
      | _ ->
          RuntimeError
            {
              phase = Check;
              command = expanded;
              exit = run.exit;
              stdout = run.stdout;
              stderr = run.stderr;
            })

let verify ~project_root ~exercises_dir exercise =
  let path = Exercise.exercise_path ~exercises_dir exercise in
  if not (Sys.file_exists path) then
    CompileError
      {
        phase = Compile;
        command = [ "ocamlfind"; "ocamlopt"; path ];
        exit = Exited 2;
        stdout = "";
        stderr = Printf.sprintf "exercise file not found: %s" path;
      }
  else
    match exercise.Exercise.check with
    | Exercise.CompileAndRun -> verify_compile_and_run path
    | Exercise.Command argv ->
        verify_custom_command ~project_root ~exercise_id:exercise.id
          ~exercise_path:path argv

let diagnostic_to_string diagnostic =
  Printf.sprintf "phase=%s status=%s\nstdout:\n%s\nstderr:\n%s"
    (phase_to_string diagnostic.phase)
    (process_exit_to_string diagnostic.exit)
    diagnostic.stdout diagnostic.stderr

let result_to_string = function
  | Success (CompileAndRunSuccess _) -> "success(compile_and_run)"
  | Success (CommandSuccess _) -> "success(command)"
  | CompileError diagnostic ->
      Printf.sprintf "compile_error\n%s" (diagnostic_to_string diagnostic)
  | RuntimeError diagnostic ->
      Printf.sprintf "runtime_error\n%s" (diagnostic_to_string diagnostic)
