(* TODO: Tail-recursive tree operations using an explicit stack *)

type 'a tree =
  | Leaf
  | Node of 'a * 'a tree * 'a tree

let sum tree =
  let rec aux acc = function
    | [] -> ???  (* No more nodes to visit, return acc *)
    | Leaf :: rest -> ???  (* Skip leaves *)
    | Node (v, left, right) :: rest -> ???  (* Add v to acc, push left and right onto the stack *)
  in
  aux 0 [tree]

let to_list tree =
  let rec aux acc = function
    | [] -> ???  (* Return the reversed accumulator *)
    | Leaf :: rest -> ???  (* Skip leaves *)
    | Node (v, left, right) :: rest ->
      ???  (* Push right, then Node(v, Leaf, Leaf), then left onto the stack
             to get in-order traversal. When left and right are both Leaf,
             add v to acc instead. *)
  in
  aux [] [tree]

let () =
  let t =
    Node (4,
      Node (2, Node (1, Leaf, Leaf), Node (3, Leaf, Leaf)),
      Node (6, Node (5, Leaf, Leaf), Node (7, Leaf, Leaf)))
  in
  assert (sum t = 28);
  assert (sum Leaf = 0);
  assert (sum (Node (42, Leaf, Leaf)) = 42);

  assert (to_list t = [1; 2; 3; 4; 5; 6; 7]);
  assert (to_list Leaf = []);

  print_endline "Tail-recursive tree traversal works!"
