(* TODO: Use CPS for early exit and backtracking *)

let find_cps pred lst ~on_found ~on_missing =
  ???
  (* Iterate through lst. If pred x is true, call on_found x.
     If no element matches, call on_missing ().
     Use a recursive CPS approach. *)

type 'a tree = Leaf | Node of 'a * 'a tree * 'a tree

let find_in_tree pred tree ~on_found ~on_missing =
  ???
  (* Search the tree for an element matching pred.
     CPS approach: search left subtree with a continuation that,
     if not found in the left, searches the right subtree.
     Check the current node's value first. *)

let () =
  find_cps (fun x -> x > 3) [1; 2; 3; 4; 5]
    ~on_found:(fun x -> assert (x = 4))
    ~on_missing:(fun () -> assert false);

  find_cps (fun x -> x > 10) [1; 2; 3]
    ~on_found:(fun _ -> assert false)
    ~on_missing:(fun () -> ());

  let tree =
    Node (5,
      Node (3, Node (1, Leaf, Leaf), Node (4, Leaf, Leaf)),
      Node (8, Node (7, Leaf, Leaf), Node (9, Leaf, Leaf)))
  in
  find_in_tree (fun x -> x = 7) tree
    ~on_found:(fun x -> assert (x = 7))
    ~on_missing:(fun () -> assert false);

  find_in_tree (fun x -> x = 6) tree
    ~on_found:(fun _ -> assert false)
    ~on_missing:(fun () -> ());

  print_endline "CPS early exit works!"
