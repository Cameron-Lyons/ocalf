let classify_number n =
  match n with
  | n when n < 0 -> "negative"
  | n when n = 0 -> "zero"
  | n when n <= 10 -> "small positive"
  | _ -> "large positive"

let () =
  assert (classify_number (-5) = "negative");
  assert (classify_number 0 = "zero");
  assert (classify_number 5 = "small positive");
  assert (classify_number 100 = "large positive");
  print_endline "Pattern matching with guards works!"
