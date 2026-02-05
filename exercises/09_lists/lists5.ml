(* TODO: Use list operations: append, concat, rev *)

let () =
  let a = [1; 2] in
  let b = [3; 4] in

  let appended = ??? in (* Append b to a using @ *)
  assert (appended = [1; 2; 3; 4]);

  let lists = [[1; 2]; [3; 4]; [5]] in
  let flattened = ??? in (* Flatten lists using List.concat *)
  assert (flattened = [1; 2; 3; 4; 5]);

  let reversed = ??? in (* Reverse [1; 2; 3] using List.rev *)
  assert (reversed = [3; 2; 1]);

  print_endline "List operations work!"
