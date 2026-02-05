(* This is a single-line comment *)

(* This is a
   multi-line comment *)

let has_single_line_comment = true
let has_multi_line_comment = true

let () =
  assert has_single_line_comment;
  assert has_multi_line_comment;
  print_endline "You understand OCaml comments!"
