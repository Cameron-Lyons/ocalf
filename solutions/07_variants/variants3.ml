type tree =
  | Leaf
  | Node of int * tree * tree

let rec tree_sum = function
  | Leaf -> 0
  | Node (v, left, right) -> v + tree_sum left + tree_sum right

let () =
  let t = Node (1, Node (2, Leaf, Leaf), Node (3, Leaf, Leaf)) in
  assert (tree_sum t = 6);
  assert (tree_sum Leaf = 0);
  print_endline "Recursive variants work!"
