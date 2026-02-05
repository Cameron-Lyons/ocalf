(* TODO: Write a recursive function to compute factorial *)

let rec factorial n =
  ???

let () =
  assert (factorial 0 = 1);
  assert (factorial 1 = 1);
  assert (factorial 5 = 120);
  assert (factorial 10 = 3628800);
  print_endline "Basic recursion works!"
