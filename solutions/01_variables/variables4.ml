let () =
  let result =
    let x = 5 in
    let y = 3 in
    x + y
  in
  assert (result = 8);
  print_endline "Scoping understood!"
