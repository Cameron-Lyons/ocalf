(* TODO: Use let open and local open in expressions *)

module IntSet = Set.Make(Int)

let evens_up_to n =
  let open IntSet in
  ???
  (* Use List.init to generate numbers 1..n, filter evens, convert to set.
     of_list (List.filter ...) *)

let set_to_string s =
  ???
  (* Use IntSet.(elements s) then String.concat with local open on Printf:
     Printf.(sprintf "%d") for each element, joined with ", " *)

let symmetric_diff a b =
  ???
  (* Use IntSet.( diff (union a b) (inter a b) ) *)

let () =
  let s = evens_up_to 10 in
  assert (IntSet.elements s = [2; 4; 6; 8; 10]);

  assert (set_to_string s = "2, 4, 6, 8, 10");

  let a = IntSet.of_list [1; 2; 3; 4] in
  let b = IntSet.of_list [3; 4; 5; 6] in
  assert (IntSet.elements (symmetric_diff a b) = [1; 2; 5; 6]);

  print_endline "Local opens in expressions work!"
