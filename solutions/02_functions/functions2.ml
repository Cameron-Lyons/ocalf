let add x y = x + y

let () =
  assert (add 2 3 = 5);
  assert (add 0 0 = 0);
  assert (add (-1) 1 = 0);
  print_endline "Multi-parameter function works!"
