let () =
  let numbers = [1; 2; 3; 4; 5] in

  let squared = List.map (fun x -> x * x) numbers in
  assert (squared = [1; 4; 9; 16; 25]);

  let sum_pairs = List.map (fun (a, b) -> a + b) [(1, 2); (3, 4); (5, 6)] in
  assert (sum_pairs = [3; 7; 11]);

  print_endline "Anonymous functions work!"
