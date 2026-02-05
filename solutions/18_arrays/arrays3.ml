let () =
  let arr = [| 1; 2; 3; 4; 5 |] in

  let doubled = Array.map (fun x -> x * 2) arr in
  assert (doubled = [| 2; 4; 6; 8; 10 |]);

  let sum = Array.fold_left ( + ) 0 arr in
  assert (sum = 15);

  let zeros = Array.make 5 0 in
  assert (zeros = [| 0; 0; 0; 0; 0 |]);

  let indices = Array.init 5 (fun i -> i) in
  assert (indices = [| 0; 1; 2; 3; 4 |]);

  print_endline "Array module functions work!"
