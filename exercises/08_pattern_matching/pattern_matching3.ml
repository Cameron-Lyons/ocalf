(* TODO: Use guards in pattern matching *)

let classify_number n =
  match n with
  | n when ??? -> "negative"
  | n when ??? -> "zero"
  | n when ??? -> "small positive"
  | _ -> "large positive"

let () =
  assert (classify_number (-5) = "negative");
  assert (classify_number 0 = "zero");
  assert (classify_number 5 = "small positive");
  assert (classify_number 100 = "large positive");
  print_endline "Pattern matching with guards works!"
