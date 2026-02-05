let () =
  let arr = [| 1; 2; 3; 4; 5 |] in

  arr.(0) <- 10;
  assert (arr.(0) = 10);

  arr.(4) <- 50;
  assert (arr.(4) = 50);

  assert (arr = [| 10; 2; 3; 4; 50 |]);
  print_endline "Array mutation works!"
