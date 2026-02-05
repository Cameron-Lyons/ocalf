let () =
  let name = "Alice" in
  let age = 30 in
  let height = 1.65 in

  let s1 = Printf.sprintf "Name: %s" name in
  assert (s1 = "Name: Alice");

  let s2 = Printf.sprintf "Age: %d" age in
  assert (s2 = "Age: 30");

  let s3 = Printf.sprintf "Height: %f" height in
  assert (String.sub s3 0 12 = "Height: 1.65");

  let s4 = Printf.sprintf "%s is %d years old" name age in
  assert (s4 = "Alice is 30 years old");

  print_endline "Printf.sprintf works!"
