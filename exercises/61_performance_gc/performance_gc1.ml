(* TODO [Easy]: Implement a tail-recursive map to avoid stack growth *)

let map_tr f xs =
  ???

let () =
  assert (map_tr (fun x -> x + 1) [ 1; 2; 3 ] = [ 2; 3; 4 ]);
  assert (map_tr String.uppercase_ascii [ "ocaml"; "fp" ] = [ "OCAML"; "FP" ]);

  let big = List.init 50_000 (fun i -> i) in
  let mapped = map_tr (fun x -> x + 1) big in
  assert (List.length mapped = 50_000);
  print_endline "Performance scaffold 1 works!"
