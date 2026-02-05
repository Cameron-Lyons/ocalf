(* TODO: Use Printf.sprintf for string formatting *)

let () =
  let name = "Alice" in
  let age = 30 in
  let height = 1.65 in

  let s1 = ???  (* Format: "Name: Alice" using %s *)
  in
  assert (s1 = "Name: Alice");

  let s2 = ???  (* Format: "Age: 30" using %d *)
  in
  assert (s2 = "Age: 30");

  let s3 = ???  (* Format: "Height: 1.65" using %f with default precision *)
  in
  assert (String.sub s3 0 12 = "Height: 1.65");

  let s4 = ???  (* Format: "Alice is 30 years old" *)
  in
  assert (s4 = "Alice is 30 years old");

  print_endline "Printf.sprintf works!"
