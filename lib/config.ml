type t = { exercises_dir : string; solutions_dir : string; info_path : string }

let default =
  {
    exercises_dir = "exercises";
    solutions_dir = "solutions";
    info_path = "exercises/info.toml";
  }

let find_project_root () =
  let rec find dir =
    let info_path = Filename.concat dir "exercises/info.toml" in
    if Sys.file_exists info_path then Some dir
    else
      let parent = Filename.dirname dir in
      if parent = dir then None else find parent
  in
  find (Sys.getcwd ())

let load () =
  match find_project_root () with
  | Some root ->
      {
        exercises_dir = Filename.concat root "exercises";
        solutions_dir = Filename.concat root "solutions";
        info_path = Filename.concat root "exercises/info.toml";
      }
  | None -> default

let load_exercises config =
  if Sys.file_exists config.info_path then
    Exercise.parse_info_toml config.info_path
  else []
