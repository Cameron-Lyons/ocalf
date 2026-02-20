let map_with f = List.map f

let id_map xs = map_with (fun x -> x) xs
let dup_map xs = map_with (fun x -> (x, x)) xs

let () =
  assert (id_map [ 1; 2; 3 ] = [ 1; 2; 3 ]);
  assert (id_map [ "a"; "b" ] = [ "a"; "b" ]);
  assert (dup_map [ 1; 2 ] = [ (1, 1); (2, 2) ]);
  assert (dup_map [ "x" ] = [ ("x", "x") ]);
  print_endline "Value restriction (eta-expansion) works!"
