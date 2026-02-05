(* TODO: Use List.fold_left *)

let () =
  let numbers = [1; 2; 3; 4; 5] in

  let sum = ??? in (* Sum all numbers using List.fold_left *)
  assert (sum = 15);

  let product = ??? in (* Multiply all numbers using List.fold_left *)
  assert (product = 120);

  print_endline "List.fold_left works!"
