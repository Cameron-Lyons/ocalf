let classify_number n =
  if n > 0 then "positive"
  else if n < 0 then "negative"
  else "zero"

let () =
  assert (classify_number 5 = "positive");
  assert (classify_number (-3) = "negative");
  assert (classify_number 0 = "zero");
  print_endline "Conditionals work!"
