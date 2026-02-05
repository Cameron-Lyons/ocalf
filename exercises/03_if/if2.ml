(* TODO: Complete the nested conditional to classify ages *)

let classify_age age =
  if age < 0 then "invalid"
  else if ??? then "child"
  else if ??? then "teenager"
  else if ??? then "adult"
  else "senior"

let () =
  assert (classify_age (-1) = "invalid");
  assert (classify_age 5 = "child");
  assert (classify_age 15 = "teenager");
  assert (classify_age 30 = "adult");
  assert (classify_age 70 = "senior");
  print_endline "Nested conditionals work!"
