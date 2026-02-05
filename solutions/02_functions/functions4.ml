let greet ?(greeting = "Hello") name = greeting ^ ", " ^ name ^ "!"

let () =
  assert (greet "Alice" = "Hello, Alice!");
  assert (greet ~greeting:"Hi" "Bob" = "Hi, Bob!");
  print_endline "Optional arguments work!"
