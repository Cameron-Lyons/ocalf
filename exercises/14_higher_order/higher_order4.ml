(* TODO: Use anonymous functions (lambdas) *)

let () =
  let numbers = [1; 2; 3; 4; 5] in

  let squared = List.map ??? numbers in (* Use fun to square each number *)
  assert (squared = [1; 4; 9; 16; 25]);

  let sum_pairs = List.map ??? [(1, 2); (3, 4); (5, 6)] in (* Sum each pair *)
  assert (sum_pairs = [3; 7; 11]);

  print_endline "Anonymous functions work!"
