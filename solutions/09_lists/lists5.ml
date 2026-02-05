let () =
  let a = [1; 2] in
  let b = [3; 4] in

  let appended = a @ b in
  assert (appended = [1; 2; 3; 4]);

  let lists = [[1; 2]; [3; 4]; [5]] in
  let flattened = List.concat lists in
  assert (flattened = [1; 2; 3; 4; 5]);

  let reversed = List.rev [1; 2; 3] in
  assert (reversed = [3; 2; 1]);

  print_endline "List operations work!"
