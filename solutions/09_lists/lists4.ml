let () =
  let numbers = [1; 2; 3; 4; 5] in

  let sum = List.fold_left ( + ) 0 numbers in
  assert (sum = 15);

  let product = List.fold_left ( * ) 1 numbers in
  assert (product = 120);

  print_endline "List.fold_left works!"
