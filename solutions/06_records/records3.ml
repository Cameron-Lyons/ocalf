type counter = { mutable count : int }

let () =
  let c = { count = 0 } in

  c.count <- c.count + 1;
  assert (c.count = 1);

  c.count <- c.count + 1;
  assert (c.count = 2);

  print_endline "Mutable records work!"
