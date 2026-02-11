module IntSet = Set.Make(Int)

let () =
  let a = IntSet.of_list [1; 2; 3; 4; 5] in
  let b = IntSet.of_list [3; 4; 5; 6; 7] in

  let union = IntSet.union a b in
  assert (IntSet.elements union = [1; 2; 3; 4; 5; 6; 7]);

  let inter = IntSet.inter a b in
  assert (IntSet.elements inter = [3; 4; 5]);

  let diff = IntSet.diff a b in
  assert (IntSet.elements diff = [1; 2]);

  let is_sub = IntSet.subset (IntSet.of_list [3; 4]) a in
  assert (is_sub = true);

  let disjoint = IntSet.disjoint (IntSet.of_list [1; 2]) (IntSet.of_list [6; 7]) in
  assert (disjoint = true);

  print_endline "Set operations work!"
