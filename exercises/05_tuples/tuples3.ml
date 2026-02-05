(* TODO: Complete the function to return multiple values as a tuple *)

let divide_with_remainder a b =
  ??? (* Return a tuple of (quotient, remainder) *)

let () =
  let (q, r) = divide_with_remainder 10 3 in
  assert (q = 3);
  assert (r = 1);

  let (q2, r2) = divide_with_remainder 20 7 in
  assert (q2 = 2);
  assert (r2 = 6);

  print_endline "Multiple return values work!"
