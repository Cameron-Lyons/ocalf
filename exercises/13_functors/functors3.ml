(* TODO: Use Set and Map functors *)

module IntSet = Set.Make(Int)
module StringMap = Map.Make(String)

let () =
  let set = ??? in (* Create a set containing 1, 2, 3 using IntSet.of_list *)
  assert (IntSet.mem 1 set);
  assert (IntSet.mem 2 set);
  assert (not (IntSet.mem 4 set));
  assert (IntSet.cardinal set = 3);

  let map = ??? in (* Create an empty StringMap, then add "a" -> 1 and "b" -> 2 *)
  assert (StringMap.find "a" map = 1);
  assert (StringMap.find "b" map = 2);

  print_endline "Set and Map functors work!"
