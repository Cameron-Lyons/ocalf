(* TODO: Create and use functional sets *)

module IntSet = Set.Make(Int)

let () =
  let s = ???  (* Create an empty IntSet using IntSet.empty *)
  in
  let s = ???  (* Add 3 using IntSet.add *)
  in
  let s = ???  (* Add 1 *)
  in
  let s = ???  (* Add 4 *)
  in
  let s = ???  (* Add 1 again *)
  in

  let size = ???  (* Get number of elements using IntSet.cardinal *)
  in
  assert (size = 3);

  let has_3 = ???  (* Check if 3 is in the set using IntSet.mem *)
  in
  assert (has_3 = true);

  let has_5 = ???  (* Check if 5 is in the set *)
  in
  assert (has_5 = false);

  let elts = ???  (* Convert to sorted list using IntSet.elements *)
  in
  assert (elts = [1; 3; 4]);

  print_endline "Set basics work!"
