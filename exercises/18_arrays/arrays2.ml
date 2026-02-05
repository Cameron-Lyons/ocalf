(* TODO: Modify arrays in place *)

let () =
  let arr = [| 1; 2; 3; 4; 5 |] in

  ??? ;  (* Set the first element to 10 *)
  assert (arr.(0) = 10);

  ??? ;  (* Set the last element to 50 *)
  assert (arr.(4) = 50);

  assert (arr = [| 10; 2; 3; 4; 50 |]);
  print_endline "Array mutation works!"
