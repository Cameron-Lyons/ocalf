let () =
  let sum = ref 0 in

  for i = 1 to 10 do
    sum := !sum + i
  done;

  assert (!sum = 55);

  let arr = [| 0; 0; 0; 0; 0 |] in

  for i = 0 to 4 do
    arr.(i) <- i * 2
  done;

  assert (arr = [| 0; 2; 4; 6; 8 |]);

  print_endline "For loops work!"
