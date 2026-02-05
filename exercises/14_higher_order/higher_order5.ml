(* TODO: Understand currying *)

let add x y = x + y

let add_explicit = ???  (* Rewrite add using explicit nested fun: fun x -> fun y -> ... *)

let () =
  assert (add 2 3 = 5);
  assert (add_explicit 2 3 = 5);

  let add2 = add 2 in  (* Partial application *)
  let add2_explicit = add_explicit 2 in

  assert (add2 5 = 7);
  assert (add2_explicit 5 = 7);

  print_endline "Currying understood!"
