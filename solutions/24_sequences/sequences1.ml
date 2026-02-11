let () =
  let s1 = Seq.empty in
  assert (List.of_seq s1 = []);

  let s2 = Seq.return 42 in
  assert (List.of_seq s2 = [42]);

  let s3 = Seq.cons 1 (List.to_seq [2; 3]) in
  assert (List.of_seq s3 = [1; 2; 3]);

  let s4 = List.to_seq [10; 20; 30] in
  assert (List.of_seq s4 = [10; 20; 30]);

  print_endline "Sequence creation works!"
