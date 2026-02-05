let greet ~name ~greeting = greeting ^ ", " ^ name ^ "!"

let () =
  assert (greet ~name:"Alice" ~greeting:"Hello" = "Hello, Alice!");
  assert (greet ~greeting:"Hi" ~name:"Bob" = "Hi, Bob!");
  print_endline "Labeled arguments work!"
