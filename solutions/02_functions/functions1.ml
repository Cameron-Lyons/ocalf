let double x = x * 2

let () =
  assert (double 5 = 10);
  assert (double 0 = 0);
  assert (double (-3) = -6);
  print_endline "Function works!"
