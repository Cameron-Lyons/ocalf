(* TODO: Pattern match on results *)

let describe_result r =
  match r with
  | ??? -> "success: " ^ string_of_int x
  | ??? -> "error: " ^ msg

let () =
  assert (describe_result (Ok 42) = "success: 42");
  assert (describe_result (Error "oops") = "error: oops");
  print_endline "Result pattern matching works!"
