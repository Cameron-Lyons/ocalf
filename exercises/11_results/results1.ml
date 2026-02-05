(* TODO: Create result values *)

let success = ???  (* Create Ok 42 *)
let failure = ???  (* Create Error "something went wrong" *)

let () =
  assert (success = Ok 42);
  assert (failure = Error "something went wrong");
  print_endline "Result values work!"
