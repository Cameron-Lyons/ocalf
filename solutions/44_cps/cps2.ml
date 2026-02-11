let rec find_cps pred lst ~on_found ~on_missing =
  match lst with
  | [] -> on_missing ()
  | x :: xs ->
    if pred x then on_found x
    else find_cps pred xs ~on_found ~on_missing

type 'a tree = Leaf | Node of 'a * 'a tree * 'a tree

let rec find_in_tree pred tree ~on_found ~on_missing =
  match tree with
  | Leaf -> on_missing ()
  | Node (v, left, right) ->
    if pred v then on_found v
    else
      find_in_tree pred left
        ~on_found
        ~on_missing:(fun () ->
          find_in_tree pred right ~on_found ~on_missing)

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
