(* TODO: Write mutually recursive functions *)

let rec is_even n =
  ???  (* Use is_odd in the definition *)
and is_odd n =
  ???  (* Use is_even in the definition *)

let () =
  assert (is_even 0 = true);
  assert (is_even 1 = false);
  assert (is_even 4 = true);
  assert (is_odd 0 = false);
  assert (is_odd 1 = true);
  assert (is_odd 5 = true);
  print_endline "Mutual recursion works!"
