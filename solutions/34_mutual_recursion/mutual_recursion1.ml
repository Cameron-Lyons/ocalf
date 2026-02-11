let rec is_even n =
  if n = 0 then true else is_odd (n - 1)

and is_odd n =
  if n = 0 then false else is_even (n - 1)

let () =
  assert (is_even 0 = true);
  assert (is_even 4 = true);
  assert (is_even 7 = false);
  assert (is_odd 0 = false);
  assert (is_odd 3 = true);
  assert (is_odd 6 = false);
  print_endline "Mutual recursion works!"
