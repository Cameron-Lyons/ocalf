(* TODO: Destructure the tuples to extract values *)

let () =
  let point = (3, 4) in
  let (x, y) = ??? in (* Destructure point *)
  assert (x = 3);
  assert (y = 4);

  let person = ("Alice", 30, true) in
  let (name, age, is_student) = ??? in (* Destructure person *)
  assert (name = "Alice");
  assert (age = 30);
  assert (is_student = true);

  print_endline "Tuples destructured!"
