let () =
  let counter = ref 0 in

  counter := !counter + 1;
  assert (!counter = 1);

  counter := 10;
  assert (!counter = 10);

  counter := !counter * 2;
  assert (!counter = 20);

  print_endline "Ref updates work!"
