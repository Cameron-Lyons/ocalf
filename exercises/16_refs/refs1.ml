(* TODO: Create and dereference refs *)

let () =
  let r = ???  (* Create a ref containing 42 *)
  in
  let value = ???  (* Dereference r to get its value *)
  in
  assert (value = 42);
  print_endline "Refs work!"
