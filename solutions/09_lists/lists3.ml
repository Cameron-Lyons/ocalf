let () =
  let numbers = [1; 2; 3; 4; 5] in

  let doubled = List.map (fun x -> x * 2) numbers in
  assert (doubled = [2; 4; 6; 8; 10]);

  let evens = List.filter (fun x -> x mod 2 = 0) numbers in
  assert (evens = [2; 4]);

  print_endline "List.map and List.filter work!"
