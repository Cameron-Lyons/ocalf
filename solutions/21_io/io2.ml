let read_lines filename =
  let ic = open_in filename in
  let rec loop acc =
    match input_line ic with
    | line -> loop (line :: acc)
    | exception End_of_file ->
        close_in ic;
        List.rev acc
  in
  loop []

let write_lines filename lines =
  let oc = open_out filename in
  List.iter (fun line -> output_string oc (line ^ "\n")) lines;
  close_out oc

let () =
  let filename = "/tmp/ocalf_lines.txt" in
  let lines = [ "first"; "second"; "third" ] in

  write_lines filename lines;
  let read_back = read_lines filename in

  assert (read_back = lines);

  Sys.remove filename;
  print_endline "Line-by-line reading works!"
