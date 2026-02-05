let () =
  let counter = ref 0 in
  let sum = ref 0 in

  while !counter < 5 do
    counter := !counter + 1;
    sum := !sum + !counter
  done;

  assert (!sum = 15);

  let n = ref 1 in
  while !n <= 100 do
    n := !n * 2
  done;

  assert (!n = 128);

  print_endline "While loops work!"
