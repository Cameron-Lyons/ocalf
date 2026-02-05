let rec factorial n =
  if n <= 1 then 1
  else n * factorial (n - 1)

let () =
  assert (factorial 0 = 1);
  assert (factorial 1 = 1);
  assert (factorial 5 = 120);
  assert (factorial 10 = 3628800);
  print_endline "Basic recursion works!"
