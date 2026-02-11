module IntSet = Set.Make(Int)

let evens_up_to n =
  let open IntSet in
  of_list (List.filter (fun x -> x mod 2 = 0) (List.init n (fun i -> i + 1)))

let set_to_string s =
  IntSet.elements s
  |> List.map (fun n -> Printf.sprintf "%d" n)
  |> String.concat ", "

let symmetric_diff a b =
  IntSet.(diff (union a b) (inter a b))

let () =
  let s = evens_up_to 10 in
  assert (IntSet.elements s = [2; 4; 6; 8; 10]);

  assert (set_to_string s = "2, 4, 6, 8, 10");

  let a = IntSet.of_list [1; 2; 3; 4] in
  let b = IntSet.of_list [3; 4; 5; 6] in
  assert (IntSet.elements (symmetric_diff a b) = [1; 2; 5; 6]);

  print_endline "Local opens in expressions work!"
