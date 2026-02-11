let () =
  let nums = List.to_seq [1; 2; 3; 4; 5] in

  let doubled = Seq.map (fun x -> x * 2) nums in
  assert (List.of_seq doubled = [2; 4; 6; 8; 10]);

  let evens = Seq.filter (fun x -> x mod 2 = 0) nums in
  assert (List.of_seq evens = [2; 4]);

  let sum = Seq.fold_left ( + ) 0 nums in
  assert (sum = 15);

  let first_two = Seq.take 2 nums in
  assert (List.of_seq first_two = [1; 2]);

  let after_two = Seq.drop 2 nums in
  assert (List.of_seq after_two = [3; 4; 5]);

  print_endline "Sequence transformations work!"
