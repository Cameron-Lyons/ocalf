let () =
  let x = lazy (21 * 2) in
  assert (Lazy.is_val x = false);

  let v = Lazy.force x in
  assert (v = 42);
  assert (Lazy.is_val x = true);

  let counter = ref 0 in
  let expensive = lazy (incr counter; !counter * 10) in

  let r1 = Lazy.force expensive in
  let r2 = Lazy.force expensive in
  assert (r1 = 10);
  assert (r2 = 10);
  assert (!counter = 1);

  print_endline "Lazy values work!"
