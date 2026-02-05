(* TODO: Complete the string operations *)

let () =
  let greeting = "Hello" in
  let name = "World" in

  let full_greeting = ??? in (* Concatenate greeting, ", ", and name *)
  assert (full_greeting = "Hello, World");

  let length = ??? in (* Get the length of full_greeting *)
  assert (length = 12);

  let first_char = ??? in (* Get the first character of greeting *)
  assert (first_char = 'H');

  print_endline "String operations work!"
