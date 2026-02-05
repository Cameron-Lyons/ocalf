(* TODO: Define a function `greet` with an optional ~greeting argument (default: "Hello") *)

let greet = ???

let () =
  assert (greet "Alice" = "Hello, Alice!");
  assert (greet ~greeting:"Hi" "Bob" = "Hi, Bob!");
  print_endline "Optional arguments work!"
