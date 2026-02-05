(* TODO: Complete the type conversions *)

let () =
  let pi = 3.14159 in
  let truncated = ??? in (* Convert pi to int *)
  assert (truncated = 3);

  let x = 42 in
  let as_float = ??? in (* Convert x to float *)
  assert (as_float = 42.0);

  let n = 123 in
  let as_string = ??? in (* Convert n to string *)
  assert (as_string = "123");

  let s = "456" in
  let as_int = ??? in (* Convert s to int *)
  assert (as_int = 456);

  print_endline "Type conversions work!"
