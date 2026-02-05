type result = Success | CompileError of string | RuntimeError of string

let run_command cmd =
  let ic = Unix.open_process_in cmd in
  let buf = Buffer.create 256 in
  (try
     while true do
       Buffer.add_channel buf ic 1
     done
   with End_of_file -> ());
  let output = Buffer.contents buf in
  let status = Unix.close_process_in ic in
  (status, output)

let run_command_both cmd =
  let stdout_file = Filename.temp_file "ocalf" "stdout" in
  let stderr_file = Filename.temp_file "ocalf" "stderr" in
  let full_cmd = Printf.sprintf "%s > %s 2> %s" cmd stdout_file stderr_file in
  let status = Unix.system full_cmd in
  let read_file path =
    let ic = open_in path in
    let len = in_channel_length ic in
    let content = really_input_string ic len in
    close_in ic;
    Sys.remove path;
    content
  in
  let stdout = read_file stdout_file in
  let stderr = read_file stderr_file in
  (status, stdout, stderr)

let verify ~exercises_dir exercise =
  let path = Exercise.exercise_path ~exercises_dir exercise in
  if not (Sys.file_exists path) then
    CompileError (Printf.sprintf "Exercise file not found: %s" path)
  else if Exercise.has_todo_marker path then
    CompileError
      "Exercise still contains TODO markers - complete the exercise first!"
  else
    let tmp_dir = Filename.temp_file "ocalf" "" in
    Sys.remove tmp_dir;
    Unix.mkdir tmp_dir 0o755;
    let exe_path = Filename.concat tmp_dir "exercise" in
    let compile_cmd =
      Printf.sprintf "ocamlfind ocamlopt -package str -linkpkg -o %s %s"
        exe_path path
    in
    let status, _stdout, stderr = run_command_both compile_cmd in
    match status with
    | Unix.WEXITED 0 -> (
        let run_cmd = exe_path in
        let status, stdout, stderr = run_command_both run_cmd in
        FileUtil.rm ~recurse:true [ tmp_dir ];
        match status with
        | Unix.WEXITED 0 -> Success
        | _ ->
            RuntimeError (Printf.sprintf "Runtime error:\n%s%s" stdout stderr))
    | _ ->
        FileUtil.rm ~recurse:true [ tmp_dir ];
        CompileError (Printf.sprintf "Compilation failed:\n%s" stderr)

let result_to_string = function
  | Success -> "Success!"
  | CompileError msg -> Printf.sprintf "Compile error: %s" msg
  | RuntimeError msg -> Printf.sprintf "Runtime error: %s" msg
