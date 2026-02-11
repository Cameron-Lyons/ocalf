(* TODO: Create and use functional maps *)

module StringMap = Map.Make(String)

let () =
  let m = ???  (* Create an empty StringMap using StringMap.empty *)
  in
  let m = ???  (* Add "alice" -> 30 using StringMap.add *)
  in
  let m = ???  (* Add "bob" -> 25 *)
  in
  let m = ???  (* Add "carol" -> 35 *)
  in

  let alice_age = ???  (* Find "alice" using StringMap.find *)
  in
  assert (alice_age = 30);

  let size = ???  (* Get number of bindings using StringMap.cardinal *)
  in
  assert (size = 3);

  let has_bob = ???  (* Check if "bob" is in the map using StringMap.mem *)
  in
  assert (has_bob = true);

  let has_dave = ???  (* Check if "dave" is in the map *)
  in
  assert (has_dave = false);

  print_endline "Map basics work!"
