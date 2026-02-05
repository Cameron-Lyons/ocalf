(* TODO: Complete the function to return "positive", "negative", or "zero" *)

let classify_number n =
  if ??? then "positive"
  else if ??? then "negative"
  else ???

let () =
  assert (classify_number 5 = "positive");
  assert (classify_number (-3) = "negative");
  assert (classify_number 0 = "zero");
  print_endline "Conditionals work!"
