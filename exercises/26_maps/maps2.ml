(* TODO: Transform and query maps *)

module IntMap = Map.Make(Int)

let () =
  let m = IntMap.of_seq (List.to_seq [(1, "one"); (2, "two"); (3, "three"); (4, "four")]) in

  let upper_m = ???  (* Use IntMap.map to uppercase all values *)
  in
  assert (IntMap.find 1 upper_m = "ONE");
  assert (IntMap.find 3 upper_m = "THREE");

  let short = ???  (* Use IntMap.filter to keep only entries where String.length value <= 3 *)
  in
  assert (IntMap.cardinal short = 2);
  assert (IntMap.mem 1 short = true);
  assert (IntMap.mem 2 short = true);

  let removed = ???  (* Remove key 2 from m using IntMap.remove *)
  in
  assert (IntMap.cardinal removed = 3);
  assert (IntMap.mem 2 removed = false);

  let opt = ???  (* Use IntMap.find_opt to look up key 99 in m *)
  in
  assert (opt = None);

  print_endline "Map transformations work!"
