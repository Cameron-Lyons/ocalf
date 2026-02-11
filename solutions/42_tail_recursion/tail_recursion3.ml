type 'a tree =
  | Leaf
  | Node of 'a * 'a tree * 'a tree

let sum tree =
  let rec aux acc = function
    | [] -> acc
    | Leaf :: rest -> aux acc rest
    | Node (v, left, right) :: rest -> aux (acc + v) (left :: right :: rest)
  in
  aux 0 [tree]

let to_list tree =
  let rec aux acc = function
    | [] -> List.rev acc
    | Leaf :: rest -> aux acc rest
    | Node (v, Leaf, Leaf) :: rest -> aux (v :: acc) rest
    | Node (v, left, right) :: rest ->
      aux acc (left :: Node (v, Leaf, Leaf) :: right :: rest)
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
