(* TODO: Use shadowing to update the value of x *)

let () =
  let x = 5 in
  (* Shadow x to make it equal to 10 *)
  assert (x = 10);
  print_endline "Shadowing works!"
