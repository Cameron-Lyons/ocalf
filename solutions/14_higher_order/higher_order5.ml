let add x y = x + y

let add_explicit = fun x -> fun y -> x + y

let () =
  assert (add 2 3 = 5);
  assert (add_explicit 2 3 = 5);

  let add2 = add 2 in
  let add2_explicit = add_explicit 2 in

  assert (add2 5 = 7);
  assert (add2_explicit 5 = 7);

  print_endline "Currying understood!"
