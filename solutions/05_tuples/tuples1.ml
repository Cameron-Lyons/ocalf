let pair = (1, "one")
let triple = (42, 3.14, true)

let () =
  assert (pair = (1, "one"));
  assert (triple = (42, 3.14, true));
  print_endline "Tuples created!"
