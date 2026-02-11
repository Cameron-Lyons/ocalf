(* TODO: Create and consume sequences *)

let () =
  let s1 = ???  (* Create an empty sequence using Seq.empty *)
  in
  assert (List.of_seq s1 = []);

  let s2 = ???  (* Create a one-element sequence with 42 using Seq.return *)
  in
  assert (List.of_seq s2 = [42]);

  let s3 = ???  (* Prepend 1 to the sequence [2; 3] using Seq.cons *)
  in
  assert (List.of_seq s3 = [1; 2; 3]);

  let s4 = ???  (* Convert [10; 20; 30] to a sequence using List.to_seq *)
  in
  assert (List.of_seq s4 = [10; 20; 30]);

  print_endline "Sequence creation works!"
