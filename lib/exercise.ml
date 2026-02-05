type status = Pending | Done

type t = {
  name : string;
  dir : string;
  hint : string;
  path : string;
  status : status;
}

let status_to_string = function Pending -> "pending" | Done -> "done"
let status_of_string = function "done" -> Done | _ -> Pending

let exercise_path ~exercises_dir exercise =
  Filename.concat exercises_dir
    (Filename.concat exercise.dir (exercise.name ^ ".ml"))

let solution_path ~solutions_dir exercise =
  Filename.concat solutions_dir
    (Filename.concat exercise.dir (exercise.name ^ ".ml"))

let parse_info_toml path : t list =
  let toml = Toml.Parser.from_filename path |> Toml.Parser.unsafe in
  let exercises_array = Toml.Types.Table.find (Toml.Min.key "exercises") toml in
  match exercises_array with
  | Toml.Types.TArray (Toml.Types.NodeTable tables) ->
      List.map
        (fun table ->
          let get_string key =
            match Toml.Types.Table.find_opt (Toml.Min.key key) table with
            | Some (Toml.Types.TString s) -> s
            | _ -> ""
          in
          let name = get_string "name" in
          let dir = get_string "dir" in
          let hint = get_string "hint" in
          {
            name;
            dir;
            hint;
            path = Filename.concat dir (name ^ ".ml");
            status = Pending;
          })
        tables
  | _ -> []

let has_todo_marker path =
  let ic = open_in path in
  let rec check () =
    match input_line ic with
    | line ->
        let dominated_by_todo =
          (String.length line >= 7 && String.sub line 0 7 = "(* TODO")
          || (String.length line >= 7 && String.sub line 0 7 = "(* I AM")
          || (String.length line >= 12 && String.sub line 0 12 = "(* COMPLETE:")
          || (String.length line >= 8 && String.sub line 0 8 = "(* todo:")
          || (String.length line >= 8 && String.sub line 0 8 = "(* TODO:")
        in
        if dominated_by_todo then (
          close_in ic;
          true)
        else check ()
    | exception End_of_file ->
        close_in ic;
        false
  in
  check ()
