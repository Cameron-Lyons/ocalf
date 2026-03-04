open Ocalf
open Cmdliner

type output_mode = Human | Json
type list_json_mode = Summary | Full

module Exit_code = struct
  let ok = 0
  let verify_failed = 2
  let not_found = 3
  let config_error = 4
  let state_error = 5
  let usage_error = 64
end

let green s = Printf.sprintf "\027[32m%s\027[0m" s
let red s = Printf.sprintf "\027[31m%s\027[0m" s
let yellow s = Printf.sprintf "\027[33m%s\027[0m" s
let bold s = Printf.sprintf "\027[1m%s\027[0m" s
let dim s = Printf.sprintf "\027[2m%s\027[0m" s

let banner =
  {|
   ___   ____      _  _   __
  / _ \ / ___|__ _| || | / _|
 | | | | |   / _` | || || |_
 | |_| | |__| (_| |  _||  _|
  \___/ \____\__,_|_||_||_|

  An OCaml Training Course
|}

let print_banner () = print_endline (yellow banner)
let output_mode_of_flag as_json = if as_json then Json else Human

let list_json_mode_to_string = function
  | Summary -> "summary"
  | Full -> "full"

let json_escape s =
  let buf = Buffer.create (String.length s) in
  String.iter
    (function
      | '"' -> Buffer.add_string buf "\\\""
      | '\\' -> Buffer.add_string buf "\\\\"
      | '\n' -> Buffer.add_string buf "\\n"
      | '\r' -> Buffer.add_string buf "\\r"
      | '\t' -> Buffer.add_string buf "\\t"
      | c -> Buffer.add_char buf c)
    s;
  Buffer.contents buf

let jstr s = Printf.sprintf "\"%s\"" (json_escape s)
let jbool b = if b then "true" else "false"
let jint i = string_of_int i
let jlist items = Printf.sprintf "[%s]" (String.concat "," items)

let jobj fields =
  let rendered =
    List.map (fun (k, v) -> Printf.sprintf "%s:%s" (jstr k) v) fields
  in
  Printf.sprintf "{%s}" (String.concat "," rendered)

let check_json check =
  match check with
  | Exercise.CompileAndRun -> jobj [ ("kind", jstr "compile_and_run") ]
  | Exercise.Command argv ->
      jobj
        [
          ("kind", jstr "command");
          ("command", jlist (List.map jstr argv));
        ]

let emit_error mode ~command ~code message =
  match mode with
  | Human ->
      Printf.eprintf "%s\n" (red (Printf.sprintf "error: %s" message));
      code
  | Json ->
      print_endline
        (jobj
           [
             ("ok", jbool false);
             ("command", jstr command);
             ("error", jstr message);
             ("exit_code", jint code);
           ]);
      code

type context = {
  config : Config.t;
  exercises : Exercise.t list;
  progress : Progress.t;
}

let load_context () =
  match Config.load () with
  | Error msg -> Error (`Config msg)
  | Ok config -> (
      match Config.load_exercises config with
      | Error msg -> Error (`Config msg)
      | Ok exercises -> (
          let progress =
            Progress.create ~path:config.state_path ~workspace_root:config.root
              ~workspace_fingerprint:config.workspace_fingerprint
          in
          match Progress.load progress with
          | Error msg -> Error (`State msg)
          | Ok _ -> Ok { config; exercises; progress }))

let find_exercise exercises id =
  List.find_opt (fun (ex : Exercise.t) -> ex.id = id) exercises

let resolve_target progress exercises target =
  if target = "next" then
    match Progress.get_current progress exercises with
    | Error msg -> Error msg
    | Ok None -> Error "no remaining exercises"
    | Ok (Some ex) -> Ok ex
  else
    match find_exercise exercises target with
    | Some ex -> Ok ex
    | None -> Error (Printf.sprintf "exercise '%s' not found" target)

let diagnostic_json diagnostic =
  jobj
    [
      ("phase", jstr (Runner.phase_to_string diagnostic.Runner.phase));
      ("status", jstr (Runner.process_exit_to_string diagnostic.exit));
      ("command", jlist (List.map jstr diagnostic.command));
      ("stdout", jstr diagnostic.stdout);
      ("stderr", jstr diagnostic.stderr);
    ]

let print_diagnostic diagnostic =
  Printf.printf "phase: %s\n" (Runner.phase_to_string diagnostic.Runner.phase);
  Printf.printf "status: %s\n" (Runner.process_exit_to_string diagnostic.exit);
  Printf.printf "command: %s\n" (String.concat " " diagnostic.command);
  if String.trim diagnostic.stdout <> "" then
    Printf.printf "\nstdout:\n%s\n" diagnostic.stdout;
  if String.trim diagnostic.stderr <> "" then
    Printf.printf "\nstderr:\n%s\n" diagnostic.stderr

let print_verify_result mode ex result persistence_error =
  match (mode, result, persistence_error) with
  | Human, Runner.Success (Runner.CompileAndRunSuccess _), None ->
      Printf.printf "%s %s\n" (green "ok") ex.Exercise.id
  | Human, Runner.Success (Runner.CompileAndRunSuccess _), Some msg ->
      Printf.printf "%s %s\n" (green "ok") ex.Exercise.id;
      Printf.printf "%s\n" (yellow (Printf.sprintf "state warning: %s" msg))
  | Human, Runner.Success (Runner.CommandSuccess summary), None ->
      Printf.printf "%s %s\n" (green "ok") ex.Exercise.id;
      Printf.printf "check command: %s\n" (String.concat " " summary.command);
      if String.trim summary.stdout <> "" then
        Printf.printf "\nstdout:\n%s\n" summary.stdout;
      if String.trim summary.stderr <> "" then
        Printf.printf "\nstderr:\n%s\n" summary.stderr
  | Human, Runner.Success (Runner.CommandSuccess summary), Some msg ->
      Printf.printf "%s %s\n" (green "ok") ex.Exercise.id;
      Printf.printf "check command: %s\n" (String.concat " " summary.command);
      if String.trim summary.stdout <> "" then
        Printf.printf "\nstdout:\n%s\n" summary.stdout;
      if String.trim summary.stderr <> "" then
        Printf.printf "\nstderr:\n%s\n" summary.stderr;
      Printf.printf "%s\n" (yellow (Printf.sprintf "state warning: %s" msg))
  | Human, Runner.CompileError diagnostic, None ->
      Printf.printf "%s %s\n" (red "compile_error") ex.Exercise.id;
      print_diagnostic diagnostic
  | Human, Runner.CompileError diagnostic, Some msg ->
      Printf.printf "%s %s\n" (red "compile_error") ex.Exercise.id;
      print_diagnostic diagnostic;
      Printf.printf "%s\n" (yellow (Printf.sprintf "state warning: %s" msg))
  | Human, Runner.RuntimeError diagnostic, None ->
      Printf.printf "%s %s\n" (red "runtime_error") ex.Exercise.id;
      print_diagnostic diagnostic
  | Human, Runner.RuntimeError diagnostic, Some msg ->
      Printf.printf "%s %s\n" (red "runtime_error") ex.Exercise.id;
      print_diagnostic diagnostic;
      Printf.printf "%s\n" (yellow (Printf.sprintf "state warning: %s" msg))
  | Json, Runner.Success (Runner.CompileAndRunSuccess summary), persistence_error
    ->
      print_endline
        (jobj
           [
             ("ok", jbool true);
             ("command", jstr "verify");
             ("exercise_id", jstr ex.id);
             ("result", jstr "success");
             ("compile_stdout", jstr summary.compile_stdout);
             ("compile_stderr", jstr summary.compile_stderr);
             ("run_stdout", jstr summary.run_stdout);
             ("run_stderr", jstr summary.run_stderr);
             ("persisted", jbool (Option.is_none persistence_error));
             ( "persistence_error",
               match persistence_error with
               | None -> "null"
               | Some msg -> jstr msg );
           ])
  | Json, Runner.Success (Runner.CommandSuccess summary), persistence_error ->
      print_endline
        (jobj
           [
             ("ok", jbool true);
             ("command", jstr "verify");
             ("exercise_id", jstr ex.id);
             ("result", jstr "success");
             ("check", check_json ex.check);
             ("command_argv", jlist (List.map jstr summary.command));
             ("stdout", jstr summary.stdout);
             ("stderr", jstr summary.stderr);
             ("persisted", jbool (Option.is_none persistence_error));
             ( "persistence_error",
               match persistence_error with
               | None -> "null"
               | Some msg -> jstr msg );
           ])
  | Json, Runner.CompileError diagnostic, persistence_error ->
      print_endline
        (jobj
           [
             ("ok", jbool false);
             ("command", jstr "verify");
             ("exercise_id", jstr ex.id);
             ("result", jstr "compile_error");
             ("diagnostic", diagnostic_json diagnostic);
             ("persisted", jbool (Option.is_none persistence_error));
             ( "persistence_error",
               match persistence_error with
               | None -> "null"
               | Some msg -> jstr msg );
           ])
  | Json, Runner.RuntimeError diagnostic, persistence_error ->
      print_endline
        (jobj
           [
             ("ok", jbool false);
             ("command", jstr "verify");
             ("exercise_id", jstr ex.id);
             ("result", jstr "runtime_error");
             ("diagnostic", diagnostic_json diagnostic);
             ("persisted", jbool (Option.is_none persistence_error));
             ( "persistence_error",
               match persistence_error with
               | None -> "null"
               | Some msg -> jstr msg );
           ])

let verify_exercise context mode exercise =
  if mode = Human then
    Printf.printf "Verifying %s (%s)\n" exercise.Exercise.id exercise.path;
  let result =
    Runner.verify ~project_root:context.config.root
      ~exercises_dir:context.config.exercises_dir exercise
  in
  let persistence =
    Progress.record_attempt context.progress ~exercise_id:exercise.id
      ~result:(Runner.result_kind_for_progress result)
  in
  let persistence_error =
    match persistence with Ok () -> None | Error msg -> Some msg
  in
  print_verify_result mode exercise result persistence_error;
  let base_code =
    match result with
    | Runner.Success _ -> Exit_code.ok
    | Runner.CompileError _ | Runner.RuntimeError _ -> Exit_code.verify_failed
  in
  match persistence_error with
  | None -> base_code
  | Some _ -> Exit_code.state_error

let run_verify as_json target =
  let mode = output_mode_of_flag as_json in
  match load_context () with
  | Error (`Config msg) ->
      emit_error mode ~command:"verify" ~code:Exit_code.config_error msg
  | Error (`State msg) ->
      emit_error mode ~command:"verify" ~code:Exit_code.state_error msg
  | Ok context -> (
      match resolve_target context.progress context.exercises target with
      | Error msg ->
          emit_error mode ~command:"verify" ~code:Exit_code.not_found msg
      | Ok exercise -> verify_exercise context mode exercise)

let run_hint as_json target =
  let mode = output_mode_of_flag as_json in
  match load_context () with
  | Error (`Config msg) ->
      emit_error mode ~command:"hint" ~code:Exit_code.config_error msg
  | Error (`State msg) ->
      emit_error mode ~command:"hint" ~code:Exit_code.state_error msg
  | Ok context -> (
      match resolve_target context.progress context.exercises target with
      | Error msg ->
          emit_error mode ~command:"hint" ~code:Exit_code.not_found msg
      | Ok exercise -> (
          match mode with
          | Human ->
              Printf.printf "Hint for %s\n\n%s\n\n" (bold exercise.id)
                exercise.hint;
              Printf.printf "topic: %s\n" exercise.topic;
              Printf.printf "difficulty: %s\n"
                (Exercise.difficulty_to_string exercise.difficulty);
              Printf.printf "check: %s\n"
                (Exercise.check_to_human exercise.check);
              Exit_code.ok
          | Json ->
              print_endline
                (jobj
                   [
                     ("ok", jbool true);
                     ("command", jstr "hint");
                     ("exercise_id", jstr exercise.id);
                     ("topic", jstr exercise.topic);
                     ( "difficulty",
                       jstr (Exercise.difficulty_to_string exercise.difficulty)
                     );
                     ("check", check_json exercise.check);
                     ("hint", jstr exercise.hint);
                   ]);
              Exit_code.ok))

let run_list as_json json_mode =
  let mode = output_mode_of_flag as_json in
  match load_context () with
  | Error (`Config msg) ->
      emit_error mode ~command:"list" ~code:Exit_code.config_error msg
  | Error (`State msg) ->
      emit_error mode ~command:"list" ~code:Exit_code.state_error msg
  | Ok context -> (
      match Progress.completed_ids context.progress with
      | Error msg ->
          emit_error mode ~command:"list" ~code:Exit_code.state_error msg
      | Ok completed_ids ->
          let total = List.length context.exercises in
          let completed =
            List.length
              (List.filter
                 (fun (ex : Exercise.t) -> List.mem ex.id completed_ids)
                 context.exercises)
          in
          let next_id =
            match Progress.get_current context.progress context.exercises with
            | Ok (Some ex) -> Some ex.id
            | Ok None -> None
            | Error _ -> None
          in
          (match mode with
          | Human ->
              Printf.printf "%s Progress: %d/%d exercises\n\n" (bold "Progress")
                completed total;
              List.iter
                (fun (ex : Exercise.t) ->
                  let done_ = List.mem ex.id completed_ids in
                  let status = if done_ then green "x" else dim " " in
                  Printf.printf "[%s] %s  (%s, %s)\n" status ex.id ex.topic
                    (Exercise.difficulty_to_string ex.difficulty))
                context.exercises
          | Json ->
              (match json_mode with
              | Summary ->
                  let next_json =
                    match next_id with None -> "null" | Some id -> jstr id
                  in
                  print_endline
                    (jobj
                       [
                         ("ok", jbool true);
                         ("command", jstr "list");
                         ("json_mode", jstr (list_json_mode_to_string json_mode));
                         ("completed", jint completed);
                         ("total", jint total);
                         ("next", next_json);
                       ])
              | Full ->
                  let exercises_json =
                    context.exercises
                    |> List.map (fun (ex : Exercise.t) ->
                           let done_ = List.mem ex.id completed_ids in
                           jobj
                             [
                               ("id", jstr ex.id);
                               ("path", jstr ex.path);
                               ("topic", jstr ex.topic);
                               ( "difficulty",
                                 jstr
                                   (Exercise.difficulty_to_string ex.difficulty)
                               );
                               ("check", check_json ex.check);
                               ("done", jbool done_);
                             ])
                  in
                  let next_json =
                    match next_id with None -> "null" | Some id -> jstr id
                  in
                  print_endline
                    (jobj
                       [
                         ("ok", jbool true);
                         ("command", jstr "list");
                         ("json_mode", jstr (list_json_mode_to_string json_mode));
                         ("completed", jint completed);
                         ("total", jint total);
                         ("next", next_json);
                         ("exercises", jlist exercises_json);
                       ])));
          Exit_code.ok)

let copy_file ~src ~dst =
  let ic = open_in_bin src in
  let oc = open_out_bin dst in
  let buffer = Bytes.create 65536 in
  let rec loop () =
    let read_count = input ic buffer 0 (Bytes.length buffer) in
    if read_count = 0 then ()
    else (
      output oc buffer 0 read_count;
      loop ())
  in
  try
    loop ();
    close_in ic;
    close_out oc;
    Ok ()
  with exn ->
    close_in_noerr ic;
    close_out_noerr oc;
    Error
      (Printf.sprintf "failed to copy %s -> %s: %s" src dst
         (Printexc.to_string exn))

let run_reset as_json target =
  let mode = output_mode_of_flag as_json in
  match load_context () with
  | Error (`Config msg) ->
      emit_error mode ~command:"reset" ~code:Exit_code.config_error msg
  | Error (`State msg) ->
      emit_error mode ~command:"reset" ~code:Exit_code.state_error msg
  | Ok context -> (
      match resolve_target context.progress context.exercises target with
      | Error msg ->
          emit_error mode ~command:"reset" ~code:Exit_code.not_found msg
      | Ok exercise -> (
          let solution_path =
            Exercise.solution_path ~solutions_dir:context.config.solutions_dir
              exercise
          in
          let exercise_path =
            Exercise.exercise_path ~exercises_dir:context.config.exercises_dir
              exercise
          in
          if not (Sys.file_exists solution_path) then
            emit_error mode ~command:"reset" ~code:Exit_code.not_found
              (Printf.sprintf "solution file not found: %s" solution_path)
          else
            match copy_file ~src:solution_path ~dst:exercise_path with
            | Error msg ->
                emit_error mode ~command:"reset" ~code:Exit_code.state_error msg
            | Ok () -> (
                match Progress.reset context.progress exercise.id with
                | Error msg ->
                    emit_error mode ~command:"reset" ~code:Exit_code.state_error
                      msg
                | Ok () ->
                    (match mode with
                    | Human ->
                        Printf.printf "Reset %s from solution\n" exercise.id
                    | Json ->
                        print_endline
                          (jobj
                             [
                               ("ok", jbool true);
                               ("command", jstr "reset");
                               ("exercise_id", jstr exercise.id);
                             ]));
                    Exit_code.ok)))

let file_mtime path =
  try Ok (Unix.stat path).st_mtime
  with exn ->
    Error (Printf.sprintf "failed to stat %s: %s" path (Printexc.to_string exn))

let rec wait_for_change path previous_mtime =
  Unix.sleepf 0.5;
  match file_mtime path with
  | Error _ -> wait_for_change path previous_mtime
  | Ok new_mtime ->
      if new_mtime > previous_mtime then new_mtime
      else wait_for_change path previous_mtime

let watch_one context mode exercise =
  let path =
    Exercise.exercise_path ~exercises_dir:context.config.exercises_dir exercise
  in
  (match mode with
  | Human ->
      Printf.printf "Watching %s (%s)\n" exercise.id path;
      Printf.printf "Waiting for file changes...\n"
  | Json ->
      print_endline
        (jobj
           [
             ("event", jstr "watching");
             ("exercise_id", jstr exercise.id);
             ("path", jstr path);
           ]));
  let rec loop () =
    let mtime =
      match file_mtime path with Ok t -> t | Error _ -> Unix.time ()
    in
    let _ = wait_for_change path mtime in
    let code = verify_exercise context mode exercise in
    if code = Exit_code.ok then Exit_code.ok
    else if code = Exit_code.verify_failed then loop ()
    else code
  in
  loop ()

let run_watch as_json target =
  let mode = output_mode_of_flag as_json in
  match load_context () with
  | Error (`Config msg) ->
      emit_error mode ~command:"watch" ~code:Exit_code.config_error msg
  | Error (`State msg) ->
      emit_error mode ~command:"watch" ~code:Exit_code.state_error msg
  | Ok context -> (
      if target = "next" then
        let rec loop_next () =
          match Progress.get_current context.progress context.exercises with
          | Error msg ->
              emit_error mode ~command:"watch" ~code:Exit_code.state_error msg
          | Ok None ->
              (match mode with
              | Human -> Printf.printf "%s\n" (green "all exercises completed")
              | Json ->
                  print_endline
                    (jobj
                       [
                         ("ok", jbool true);
                         ("command", jstr "watch");
                         ("event", jstr "complete");
                       ]));
              Exit_code.ok
          | Ok (Some exercise) ->
              let code = watch_one context mode exercise in
              if code = Exit_code.ok then loop_next () else code
        in
        loop_next ()
      else
        match resolve_target context.progress context.exercises target with
        | Error msg ->
            emit_error mode ~command:"watch" ~code:Exit_code.not_found msg
        | Ok exercise -> watch_one context mode exercise)

let run_default as_json =
  let mode = output_mode_of_flag as_json in
  match load_context () with
  | Error (`Config msg) ->
      emit_error mode ~command:"default" ~code:Exit_code.config_error msg
  | Error (`State msg) ->
      emit_error mode ~command:"default" ~code:Exit_code.state_error msg
  | Ok context -> (
      match
        ( Progress.count_completed context.progress context.exercises,
          Progress.get_current context.progress context.exercises )
      with
      | Error msg, _ | _, Error msg ->
          emit_error mode ~command:"default" ~code:Exit_code.state_error msg
      | Ok completed, Ok next ->
          let total = List.length context.exercises in
          (match mode with
          | Human ->
              print_banner ();
              Printf.printf "Progress: %d/%d exercises\n\n" completed total;
              (match next with
              | None -> Printf.printf "%s\n" (green "all exercises completed")
              | Some exercise ->
                  Printf.printf "Next exercise: %s\n" (bold exercise.id);
                  Printf.printf "Path: %s\n\n"
                    (Exercise.exercise_path
                       ~exercises_dir:context.config.exercises_dir exercise));
              Printf.printf "Commands:\n";
              Printf.printf "  ocalf list\n";
              Printf.printf "  ocalf verify <id|next>\n";
              Printf.printf "  ocalf hint <id|next>\n";
              Printf.printf "  ocalf watch <id|next>\n";
              Printf.printf "  ocalf reset <id|next>\n";
              Printf.printf "  Add --json for machine output\n";
              Printf.printf
                "  For list JSON detail: ocalf list --json --json-mode full\n"
          | Json ->
              let next_json =
                match next with
                | None -> "null"
                | Some exercise -> jstr exercise.id
              in
              print_endline
                (jobj
                   [
                     ("ok", jbool true);
                     ("command", jstr "default");
                     ("completed", jint completed);
                     ("total", jint total);
                     ("next", next_json);
                   ]));
          Exit_code.ok)

let json_flag =
  Arg.(value & flag & info [ "json" ] ~doc:"Emit machine-readable JSON output")

let list_json_mode_arg =
  Arg.(
    value
    & opt (enum [ ("summary", Summary); ("full", Full) ]) Summary
    & info [ "json-mode" ] ~docv:"MODE"
        ~doc:"JSON detail mode for `list` output (`summary` or `full`).")

let target_arg =
  Arg.(
    required
    & pos 0 (some string) None
    & info [] ~docv:"TARGET"
        ~doc:"Exercise target (explicit exercise id or 'next').")

let verify_cmd =
  let doc = "Verify an exercise" in
  let info = Cmd.info "verify" ~doc in
  Cmd.v info Term.(const run_verify $ json_flag $ target_arg)

let hint_cmd =
  let doc = "Show hint for an exercise" in
  let info = Cmd.info "hint" ~doc in
  Cmd.v info Term.(const run_hint $ json_flag $ target_arg)

let list_cmd =
  let doc = "List all exercises" in
  let info = Cmd.info "list" ~doc in
  Cmd.v info Term.(const run_list $ json_flag $ list_json_mode_arg)

let reset_cmd =
  let doc = "Reset an exercise to original state" in
  let info = Cmd.info "reset" ~doc in
  Cmd.v info Term.(const run_reset $ json_flag $ target_arg)

let watch_cmd =
  let doc = "Watch mode - auto-verify on file changes" in
  let info = Cmd.info "watch" ~doc in
  Cmd.v info Term.(const run_watch $ json_flag $ target_arg)

let main_cmd =
  let doc = "An OCaml training course" in
  let info = Cmd.info "ocalf" ~version:"0.1.0" ~doc in
  Cmd.group info
    ~default:Term.(const run_default $ json_flag)
    [ verify_cmd; hint_cmd; list_cmd; reset_cmd; watch_cmd ]

let () =
  match Cmd.eval_value main_cmd with
  | Ok (`Ok code) -> exit code
  | Ok (`Version | `Help) -> exit Exit_code.ok
  | Error _ -> exit Exit_code.usage_error
