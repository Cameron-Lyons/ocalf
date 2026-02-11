let () =
  let countdown =
    Seq.unfold
      (fun n -> if n = 0 then None else Some (n, n - 1))
      5
  in
  assert (List.of_seq countdown = [5; 4; 3; 2; 1]);

  let fibs =
    Seq.unfold
      (fun (a, b) -> Some (a, (b, a + b)))
      (0, 1)
  in
  let first_eight = List.of_seq (Seq.take 8 fibs) in
  assert (first_eight = [0; 1; 1; 2; 3; 5; 8; 13]);

  let squares =
    Seq.ints 1 |> Seq.map (fun n -> n * n) |> Seq.take 5
  in
  assert (List.of_seq squares = [1; 4; 9; 16; 25]);

  print_endline "Sequence generation works!"
