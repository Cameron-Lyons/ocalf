let () =
  let x = 5 in
  let x = x + 5 in
  assert (x = 10);
  print_endline "Shadowing works!"
