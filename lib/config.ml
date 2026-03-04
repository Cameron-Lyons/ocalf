type t = {
  root : string;
  exercises_dir : string;
  solutions_dir : string;
  manifest_path : string;
  state_path : string;
  workspace_fingerprint : string;
}

let manifest_rel_path = Filename.concat "exercises" "info.toml"

let find_project_root () =
  let rec find dir =
    let manifest_path = Filename.concat dir manifest_rel_path in
    if Sys.file_exists manifest_path then Some dir
    else
      let parent = Filename.dirname dir in
      if parent = dir then None else find parent
  in
  find (Sys.getcwd ())

let load () =
  match find_project_root () with
  | None ->
      Error
        (Printf.sprintf "could not locate %s from %s" manifest_rel_path
           (Sys.getcwd ()))
  | Some root ->
      let manifest_path = Filename.concat root manifest_rel_path in
      if not (Sys.file_exists manifest_path) then
        Error (Printf.sprintf "manifest file missing: %s" manifest_path)
      else
        let workspace_fingerprint = Digest.to_hex (Digest.string root) in
        Ok
          {
            root;
            exercises_dir = Filename.concat root "exercises";
            solutions_dir = Filename.concat root "solutions";
            manifest_path;
            state_path = Filename.concat root ".ocalf-state.toml";
            workspace_fingerprint;
          }

let load_exercises config = Exercise.parse_info_toml config.manifest_path
