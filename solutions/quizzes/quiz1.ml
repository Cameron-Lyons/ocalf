let q1_variable = "OCaml"

let q2_add_three x = x + 3

let q3_greet ?(prefix = "Hello") name = prefix ^ ", " ^ name ^ "!"

let q4_classify n =
  if n > 0 then "positive"
  else if n < 0 then "negative"
  else "zero"

let q5_apply_if_positive f n =
  if n > 0 then f n else n

let () =
  assert (q1_variable = "OCaml");
  assert (q2_add_three 7 = 10);
  assert (q2_add_three (-3) = 0);
  assert (q3_greet "World" = "Hello, World!");
  assert (q3_greet ~prefix:"Hi" "Alice" = "Hi, Alice!");
  assert (q4_classify 5 = "positive");
  assert (q4_classify (-3) = "negative");
  assert (q4_classify 0 = "zero");
  assert (q5_apply_if_positive (fun x -> x * 2) 5 = 10);
  assert (q5_apply_if_positive (fun x -> x * 2) (-3) = -3);
  print_endline "Quiz 1 complete!"
