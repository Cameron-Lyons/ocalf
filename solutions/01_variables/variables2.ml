let () =
  let name : string = "Alice" in
  let age : int = 30 in
  let is_student : bool = false in
  let height : float = 1.65 in
  assert (name = "Alice");
  assert (age = 30);
  assert (is_student = false);
  assert (height = 1.65);
  print_endline "All types annotated correctly!"
