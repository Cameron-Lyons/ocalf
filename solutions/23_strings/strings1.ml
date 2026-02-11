let () =
  let s = "Hello, OCaml!" in

  let len = String.length s in
  assert (len = 13);

  let upper = String.uppercase_ascii s in
  assert (upper = "HELLO, OCAML!");

  let lower = String.lowercase_ascii s in
  assert (lower = "hello, ocaml!");

  let sub = String.sub s 7 5 in
  assert (sub = "OCaml");

  let ch = String.get s 0 in
  assert (ch = 'H');

  print_endline "String basics work!"
