let () =
  let pi = 3.14159 in
  let truncated = int_of_float pi in
  assert (truncated = 3);

  let x = 42 in
  let as_float = float_of_int x in
  assert (as_float = 42.0);

  let n = 123 in
  let as_string = string_of_int n in
  assert (as_string = "123");

  let s = "456" in
  let as_int = int_of_string s in
  assert (as_int = 456);

  print_endline "Type conversions work!"
