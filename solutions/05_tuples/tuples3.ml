let divide_with_remainder a b =
  (a / b, a mod b)

let () =
  let (q, r) = divide_with_remainder 10 3 in
  assert (q = 3);
  assert (r = 1);

  let (q2, r2) = divide_with_remainder 20 7 in
  assert (q2 = 2);
  assert (r2 = 6);

  print_endline "Multiple return values work!"
