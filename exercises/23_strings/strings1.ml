(* TODO: Use basic String module functions *)

let () =
  let s = "Hello, OCaml!" in

  let len = ???  (* Get the length of s *)
  in
  assert (len = 13);

  let upper = ???  (* Convert s to uppercase *)
  in
  assert (upper = "HELLO, OCAML!");

  let lower = ???  (* Convert s to lowercase *)
  in
  assert (lower = "hello, ocaml!");

  let sub = ???  (* Extract "OCaml" from s using String.sub *)
  in
  assert (sub = "OCaml");

  let ch = ???  (* Get the character at index 0 *)
  in
  assert (ch = 'H');

  print_endline "String basics work!"
