let () =
  let arr = [| 1; 2; 3; 4; 5 |] in
  let first = arr.(0) in
  let len = Array.length arr in
  assert (first = 1);
  assert (len = 5);
  assert (arr.(2) = 3);
  print_endline "Array creation works!"
