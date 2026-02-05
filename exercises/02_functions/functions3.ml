(* TODO: Define a function `greet` with labeled arguments ~name and ~greeting *)

let greet = ???

let () =
  assert (greet ~name:"Alice" ~greeting:"Hello" = "Hello, Alice!");
  assert (greet ~greeting:"Hi" ~name:"Bob" = "Hi, Bob!");
  print_endline "Labeled arguments work!"
