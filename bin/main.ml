open Ocalf
open Cmdliner

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

let verify_exercise config exercise =
  let _path =
    Exercise.exercise_path ~exercises_dir:config.Config.exercises_dir exercise
  in
  Printf.printf "Verifying %s...\n" (bold exercise.Exercise.name);
  let result = Runner.verify ~exercises_dir:config.exercises_dir exercise in
  match result with
  | Runner.Success ->
      Printf.printf "%s %s\n" (green "✓") exercise.name;
      Progress.mark_done exercise.name;
      true
  | Runner.CompileError msg ->
      Printf.printf "%s %s\n%s\n" (red "✗") exercise.name msg;
      false
  | Runner.RuntimeError msg ->
      Printf.printf "%s %s\n%s\n" (red "✗") exercise.name msg;
      false

let run_verify name =
  let config = Config.load () in
  let exercises = Config.load_exercises config in
  match name with
  | Some n -> (
      match List.find_opt (fun (e : Exercise.t) -> e.name = n) exercises with
      | Some ex ->
          let _ = verify_exercise config ex in
          `Ok ()
      | None ->
          Printf.printf "Exercise '%s' not found\n" n;
          `Ok ())
  | None -> (
      match Progress.get_current exercises with
      | Some ex ->
          let _ = verify_exercise config ex in
          `Ok ()
      | None ->
          Printf.printf "%s All exercises completed!\n" (green "🎉");
          `Ok ())

let run_hint name =
  let config = Config.load () in
  let exercises = Config.load_exercises config in
  let exercise =
    match name with
    | Some n -> List.find_opt (fun (e : Exercise.t) -> e.name = n) exercises
    | None -> Progress.get_current exercises
  in
  match exercise with
  | Some ex ->
      Printf.printf "%s Hint for %s:\n\n%s\n" (yellow "💡") (bold ex.name)
        ex.hint;
      `Ok ()
  | None ->
      Printf.printf "No current exercise or exercise not found\n";
      `Ok ()

let run_list () =
  let config = Config.load () in
  let exercises = Config.load_exercises config in
  let completed = Progress.count_completed exercises in
  let total = List.length exercises in
  Printf.printf "%s Progress: %d/%d exercises\n\n" (bold "📊") completed total;
  List.iter
    (fun (ex : Exercise.t) ->
      let status = if Progress.is_done ex.name then green "✓" else dim "○" in
      Printf.printf "  %s %s\n" status ex.name)
    exercises;
  `Ok ()

let run_reset name =
  let config = Config.load () in
  let exercises = Config.load_exercises config in
  match name with
  | Some n -> (
      match List.find_opt (fun (e : Exercise.t) -> e.name = n) exercises with
      | Some ex ->
          let solution_path =
            Exercise.solution_path ~solutions_dir:config.solutions_dir ex
          in
          let exercise_path =
            Exercise.exercise_path ~exercises_dir:config.exercises_dir ex
          in
          if Sys.file_exists solution_path then (
            let ic = open_in solution_path in
            let len = in_channel_length ic in
            let content = really_input_string ic len in
            close_in ic;
            let oc = open_out exercise_path in
            output_string oc content;
            close_out oc;
            Progress.reset ex.name;
            Printf.printf "Reset %s to original state\n" ex.name;
            `Ok ())
          else (
            Printf.printf "Solution file not found for %s\n" ex.name;
            `Ok ())
      | None ->
          Printf.printf "Exercise '%s' not found\n" n;
          `Ok ())
  | None ->
      Printf.printf "Please specify an exercise name to reset\n";
      `Ok ()

let run_watch () =
  print_banner ();
  let config = Config.load () in
  let exercises = Config.load_exercises config in
  Printf.printf "Watching for changes... (Ctrl+C to quit)\n\n";
  let rec loop () =
    match Progress.get_current exercises with
    | None ->
        Printf.printf "%s Congratulations! All exercises completed!\n"
          (green "🎉");
        `Ok ()
    | Some ex ->
        let path =
          Exercise.exercise_path ~exercises_dir:config.exercises_dir ex
        in
        Printf.printf "Current exercise: %s\n" (bold ex.name);
        Printf.printf "  Edit: %s\n" path;
        Printf.printf "  Run 'ocalf hint' for hints\n\n";
        Printf.printf "Waiting for file changes...\n";
        let mtime = (Unix.stat path).st_mtime in
        let rec wait_for_change () =
          Unix.sleepf 0.5;
          let new_mtime = (Unix.stat path).st_mtime in
          if new_mtime > mtime then (
            Printf.printf "\nFile changed, verifying...\n";
            if verify_exercise config ex then (
              Printf.printf "\n%s Moving to next exercise...\n\n" (green "✓");
              loop ())
            else (
              Printf.printf "\nKeep working on it!\n";
              wait_for_change ()))
          else wait_for_change ()
        in
        wait_for_change ()
  in
  loop ()

let run_default () =
  print_banner ();
  let config = Config.load () in
  let exercises = Config.load_exercises config in
  let completed = Progress.count_completed exercises in
  let total = List.length exercises in
  Printf.printf "Progress: %d/%d exercises\n\n" completed total;
  match Progress.get_current exercises with
  | None ->
      Printf.printf "%s All exercises completed!\n" (green "🎉");
      `Ok ()
  | Some ex ->
      let path =
        Exercise.exercise_path ~exercises_dir:config.exercises_dir ex
      in
      Printf.printf "Current exercise: %s\n" (bold ex.name);
      Printf.printf "  Path: %s\n\n" path;
      Printf.printf "Commands:\n";
      Printf.printf "  ocalf verify  - Verify current exercise\n";
      Printf.printf "  ocalf hint    - Show hint\n";
      Printf.printf "  ocalf list    - List all exercises\n";
      Printf.printf "  ocalf watch   - Watch mode\n";
      Printf.printf "  ocalf reset   - Reset an exercise\n";
      `Ok ()

let name_arg = Arg.(value & pos 0 (some string) None & info [] ~docv:"NAME")

let verify_cmd =
  let doc = "Verify an exercise" in
  let info = Cmd.info "verify" ~doc in
  Cmd.v info Term.(ret (const run_verify $ name_arg))

let hint_cmd =
  let doc = "Show hint for an exercise" in
  let info = Cmd.info "hint" ~doc in
  Cmd.v info Term.(ret (const run_hint $ name_arg))

let list_cmd =
  let doc = "List all exercises" in
  let info = Cmd.info "list" ~doc in
  Cmd.v info Term.(ret (const run_list $ const ()))

let reset_cmd =
  let doc = "Reset an exercise to original state" in
  let info = Cmd.info "reset" ~doc in
  Cmd.v info Term.(ret (const run_reset $ name_arg))

let watch_cmd =
  let doc = "Watch mode - auto-verify on file changes" in
  let info = Cmd.info "watch" ~doc in
  Cmd.v info Term.(ret (const run_watch $ const ()))

let main_cmd =
  let doc = "An OCaml training course" in
  let info = Cmd.info "ocalf" ~version:"0.1.0" ~doc in
  Cmd.group info
    ~default:Term.(ret (const run_default $ const ()))
    [ verify_cmd; hint_cmd; list_cmd; reset_cmd; watch_cmd ]

let () = exit (Cmd.eval main_cmd)
