let () =
  let greeting = "Hello" in
  let name = "World" in

  let full_greeting = greeting ^ ", " ^ name in
  assert (full_greeting = "Hello, World");

  let length = String.length full_greeting in
  assert (length = 12);

  let first_char = String.get greeting 0 in
  assert (first_char = 'H');

  print_endline "String operations work!"
