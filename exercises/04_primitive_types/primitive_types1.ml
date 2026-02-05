(* TODO: Fix the type errors by providing correct values *)

let my_int : int = ???
let my_float : float = ???
let my_bool : bool = ???
let my_char : char = ???

let () =
  assert (my_int = 42);
  assert (my_float = 3.14);
  assert (my_bool = true);
  assert (my_char = 'x');
  print_endline "Primitive types work!"
