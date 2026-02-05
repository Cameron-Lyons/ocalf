let progress_file = ".ocalf-progress"

let load () : string list =
  if Sys.file_exists progress_file then
    let ic = open_in progress_file in
    let rec read_lines acc =
      match input_line ic with
      | line -> read_lines (String.trim line :: acc)
      | exception End_of_file ->
          close_in ic;
          List.rev acc
    in
    read_lines []
  else []

let save completed =
  let oc = open_out progress_file in
  List.iter (fun name -> Printf.fprintf oc "%s\n" name) completed;
  close_out oc

let mark_done name =
  let completed = load () in
  if not (List.mem name completed) then save (name :: completed)

let is_done name =
  let completed = load () in
  List.mem name completed

let reset name =
  let completed = load () in
  let filtered = List.filter (fun n -> n <> name) completed in
  save filtered

let reset_all () =
  if Sys.file_exists progress_file then Sys.remove progress_file

let get_current exercises =
  let completed = load () in
  List.find_opt
    (fun (ex : Exercise.t) -> not (List.mem ex.name completed))
    exercises

let count_completed exercises =
  let completed = load () in
  List.length
    (List.filter
       (fun (ex : Exercise.t) -> List.mem ex.name completed)
       exercises)
