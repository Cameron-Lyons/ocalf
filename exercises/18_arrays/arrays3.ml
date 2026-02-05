(* TODO: Use Array module functions *)

let () =
  let arr = [| 1; 2; 3; 4; 5 |] in

  let doubled = ???  (* Use Array.map to double each element *)
  in
  assert (doubled = [| 2; 4; 6; 8; 10 |]);

  let sum = ???  (* Use Array.fold_left to sum elements *)
  in
  assert (sum = 15);

  let zeros = ???  (* Create an array of 5 zeros using Array.make *)
  in
  assert (zeros = [| 0; 0; 0; 0; 0 |]);

  let indices = ???  (* Create [| 0; 1; 2; 3; 4 |] using Array.init *)
  in
  assert (indices = [| 0; 1; 2; 3; 4 |]);

  print_endline "Array module functions work!"
