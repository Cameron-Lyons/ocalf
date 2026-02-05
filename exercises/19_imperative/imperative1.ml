(* TODO: Use for loops *)

let () =
  let sum = ref 0 in

  (* Use a for loop to add numbers 1 to 10 to sum *)
  ??? ;

  assert (!sum = 55);

  let arr = [| 0; 0; 0; 0; 0 |] in

  (* Use a for loop to set arr.(i) = i * 2 *)
  ??? ;

  assert (arr = [| 0; 2; 4; 6; 8 |]);

  print_endline "For loops work!"
