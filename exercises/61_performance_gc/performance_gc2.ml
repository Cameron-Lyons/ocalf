(* TODO [Medium]: Join strings with Buffer instead of repeated (^) concatenation *)

let join_with_sep sep parts =
  ???

let () =
  assert (join_with_sep "," [ "a"; "b"; "c" ] = "a,b,c");
  assert (join_with_sep "::" [ "x"; "y" ] = "x::y");

  let parts = List.init 5000 (fun _ -> "x") in
  let joined = join_with_sep "," parts in
  assert (String.length joined = 9999);
  print_endline "Performance scaffold 2 works!"
