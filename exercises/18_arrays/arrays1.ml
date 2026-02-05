(* TODO: Create and access arrays *)

let () =
  let arr = ???  (* Create an array [| 1; 2; 3; 4; 5 |] *)
  in
  let first = ???  (* Get the first element *)
  in
  let len = ???  (* Get the array length *)
  in
  assert (first = 1);
  assert (len = 5);
  assert (arr.(2) = 3);
  print_endline "Array creation works!"
