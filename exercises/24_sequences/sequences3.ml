(* TODO: Create sequences with Seq.unfold and Seq.ints *)

let () =
  let countdown = ???
    (* Use Seq.unfold to generate [5; 4; 3; 2; 1]
       Seq.unfold takes a function: state -> (element * next_state) option
       Return None when state reaches 0 *)
  in
  assert (List.of_seq countdown = [5; 4; 3; 2; 1]);

  let fibs =
    Seq.unfold
      (fun (a, b) -> ???)  (* Generate Fibonacci pairs: yield a, next state is (b, a+b) *)
      (0, 1)
  in
  let first_eight = ???  (* Take the first 8 Fibonacci numbers from fibs *)
  in
  assert (first_eight = [0; 1; 1; 2; 3; 5; 8; 13]);

  let squares = ???
    (* Use Seq.ints starting at 1, then Seq.map to square, then Seq.take 5 *)
  in
  assert (List.of_seq squares = [1; 4; 9; 16; 25]);

  print_endline "Sequence generation works!"
