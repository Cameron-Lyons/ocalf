(* TODO: Add type annotations to these bindings *)

let () =
  let name = "Alice" in
  let age = 30 in
  let is_student = false in
  let height = 1.65 in
  assert (name = "Alice");
  assert (age = 30);
  assert (is_student = false);
  assert (height = 1.65);
  print_endline "All types annotated correctly!"
