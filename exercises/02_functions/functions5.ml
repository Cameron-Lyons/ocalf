(* TODO: Use partial application to create `add5` from the `add` function *)

let add x y = x + y

let add5 = ???

let () =
  assert (add5 10 = 15);
  assert (add5 0 = 5);
  assert (add5 (-5) = 0);
  print_endline "Partial application works!"
