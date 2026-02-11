module IntMap = Map.Make(Int)

let () =
  let m = IntMap.of_seq (List.to_seq [(1, "one"); (2, "two"); (3, "three"); (4, "four")]) in

  let upper_m = IntMap.map String.uppercase_ascii m in
  assert (IntMap.find 1 upper_m = "ONE");
  assert (IntMap.find 3 upper_m = "THREE");

  let short = IntMap.filter (fun _ v -> String.length v <= 3) m in
  assert (IntMap.cardinal short = 2);
  assert (IntMap.mem 1 short = true);
  assert (IntMap.mem 2 short = true);

  let removed = IntMap.remove 2 m in
  assert (IntMap.cardinal removed = 3);
  assert (IntMap.mem 2 removed = false);

  let opt = IntMap.find_opt 99 m in
  assert (opt = None);

  print_endline "Map transformations work!"
