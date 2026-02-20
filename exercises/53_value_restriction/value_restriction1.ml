(* TODO [Easy]: Use eta-expansion so this stays polymorphic after partial application *)

let map_with f = List.map f

let id_map = ???  (* Define as a function of xs, not a bare partial application *)
let dup_map = ???  (* Return (x, x) for each element *)

let () =
  assert (id_map [ 1; 2; 3 ] = [ 1; 2; 3 ]);
  assert (id_map [ "a"; "b" ] = [ "a"; "b" ]);
  assert (dup_map [ 1; 2 ] = [ (1, 1); (2, 2) ]);
  assert (dup_map [ "x" ] = [ ("x", "x") ]);
  print_endline "Value restriction (eta-expansion) works!"
