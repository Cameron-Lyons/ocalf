module IntSet = Set.Make(Int)
module StringMap = Map.Make(String)

let () =
  let set = IntSet.of_list [1; 2; 3] in
  assert (IntSet.mem 1 set);
  assert (IntSet.mem 2 set);
  assert (not (IntSet.mem 4 set));
  assert (IntSet.cardinal set = 3);

  let map =
    StringMap.empty
    |> StringMap.add "a" 1
    |> StringMap.add "b" 2
  in
  assert (StringMap.find "a" map = 1);
  assert (StringMap.find "b" map = 2);

  print_endline "Set and Map functors work!"
