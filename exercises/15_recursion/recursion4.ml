(* TODO: Write a recursive function over a tree *)

type tree =
  | Leaf
  | Node of int * tree * tree

let rec tree_height = function
  | Leaf -> ???
  | Node (_, left, right) -> ???

let () =
  assert (tree_height Leaf = 0);
  assert (tree_height (Node (1, Leaf, Leaf)) = 1);
  let big_tree = Node (1, Node (2, Node (3, Leaf, Leaf), Leaf), Node (4, Leaf, Leaf)) in
  assert (tree_height big_tree = 3);
  print_endline "Recursive data structures work!"
