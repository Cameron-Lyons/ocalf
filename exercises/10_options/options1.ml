(* TODO: Create optional values *)

let some_value = ???  (* Create Some 42 *)
let no_value = ???    (* Create None *)

let () =
  assert (some_value = Some 42);
  assert (no_value = None);
  print_endline "Option values work!"
