module IntSet = Set.Make(Int)

let () =
  let s = IntSet.empty in
  let s = IntSet.add 3 s in
  let s = IntSet.add 1 s in
  let s = IntSet.add 4 s in
  let s = IntSet.add 1 s in

  let size = IntSet.cardinal s in
  assert (size = 3);

  let has_3 = IntSet.mem 3 s in
  assert (has_3 = true);

  let has_5 = IntSet.mem 5 s in
  assert (has_5 = false);

  let elts = IntSet.elements s in
  assert (elts = [1; 3; 4]);

  print_endline "Set basics work!"
