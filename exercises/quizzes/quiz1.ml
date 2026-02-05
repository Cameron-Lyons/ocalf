(* TODO: Quiz 1 - Variables, Functions, and Conditionals *)

let q1_variable = ???  (* Bind the string "OCaml" to this variable *)

let q2_add_three x = ???  (* Add 3 to x *)

let q3_greet ?(prefix = "Hello") name = ???  (* Return prefix ^ ", " ^ name ^ "!" *)

let q4_classify n =
  ???  (* Return "positive" if n > 0, "negative" if n < 0, "zero" otherwise *)

let q5_apply_if_positive f n =
  ???  (* Apply f to n if n > 0, otherwise return n unchanged *)

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
