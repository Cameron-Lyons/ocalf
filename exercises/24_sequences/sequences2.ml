(* TODO: Transform sequences with map, filter, and fold *)

let () =
  let nums = List.to_seq [1; 2; 3; 4; 5] in

  let doubled = ???  (* Double each element using Seq.map *)
  in
  assert (List.of_seq doubled = [2; 4; 6; 8; 10]);

  let evens = ???  (* Keep only even numbers from nums using Seq.filter *)
  in
  assert (List.of_seq evens = [2; 4]);

  let sum = ???  (* Sum all elements in nums using Seq.fold_left *)
  in
  assert (sum = 15);

  let first_two = ???  (* Take the first 2 elements from nums using Seq.take *)
  in
  assert (List.of_seq first_two = [1; 2]);

  let after_two = ???  (* Drop the first 2 elements from nums using Seq.drop *)
  in
  assert (List.of_seq after_two = [3; 4; 5]);

  print_endline "Sequence transformations work!"
