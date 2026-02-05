(* TODO: Write to a file *)

let write_file filename content =
  ???  (* Open file for writing, write content, close the channel *)

let read_file filename =
  let ic = open_in filename in
  let len = in_channel_length ic in
  let content = really_input_string ic len in
  close_in ic;
  content

let () =
  let filename = "/tmp/ocalf_test.txt" in
  let content = "Hello, OCaml!" in

  write_file filename content;

  let read_content = read_file filename in
  assert (read_content = content);

  Sys.remove filename;
  print_endline "File writing works!"
