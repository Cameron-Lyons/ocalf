let abs n =
  if n < 0 then -n else n

let () =
  assert (abs 5 = 5);
  assert (abs (-5) = 5);
  assert (abs 0 = 0);
  print_endline "If expressions work!"
