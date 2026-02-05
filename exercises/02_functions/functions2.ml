(* TODO: Define a function `add` that takes two parameters and returns their sum *)

let add = ???

let () =
  assert (add 2 3 = 5);
  assert (add 0 0 = 0);
  assert (add (-1) 1 = 0);
  print_endline "Multi-parameter function works!"
