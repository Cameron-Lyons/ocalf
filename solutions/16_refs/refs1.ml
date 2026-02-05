let () =
  let r = ref 42 in
  let value = !r in
  assert (value = 42);
  print_endline "Refs work!"
