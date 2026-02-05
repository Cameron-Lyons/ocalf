let my_int : int = 42
let my_float : float = 3.14
let my_bool : bool = true
let my_char : char = 'x'

let () =
  assert (my_int = 42);
  assert (my_float = 3.14);
  assert (my_bool = true);
  assert (my_char = 'x');
  print_endline "Primitive types work!"
