(* TODO: Use set operations: union, intersection, difference *)

module IntSet = Set.Make(Int)

let () =
  let a = IntSet.of_list [1; 2; 3; 4; 5] in
  let b = IntSet.of_list [3; 4; 5; 6; 7] in

  let union = ???  (* Compute the union of a and b *)
  in
  assert (IntSet.elements union = [1; 2; 3; 4; 5; 6; 7]);

  let inter = ???  (* Compute the intersection of a and b *)
  in
  assert (IntSet.elements inter = [3; 4; 5]);

  let diff = ???  (* Compute elements in a but not in b using IntSet.diff *)
  in
  assert (IntSet.elements diff = [1; 2]);

  let is_sub = ???  (* Check if {3; 4} is a subset of a using IntSet.subset *)
  in
  assert (is_sub = true);

  let disjoint = ???  (* Check if {1; 2} and {6; 7} are disjoint using IntSet.disjoint *)
  in
  assert (disjoint = true);

  print_endline "Set operations work!"
