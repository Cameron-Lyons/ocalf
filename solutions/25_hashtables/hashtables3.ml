let () =
  let tbl = Hashtbl.create 16 in
  Hashtbl.add tbl "a" 1;
  Hashtbl.add tbl "b" 2;
  Hashtbl.add tbl "c" 3;

  let sum = ref 0 in
  Hashtbl.iter (fun _ v -> sum := !sum + v) tbl;
  assert (!sum = 6);

  let pairs = List.of_seq (Hashtbl.to_seq tbl) in
  let sorted = List.sort (fun (a, _) (b, _) -> String.compare a b) pairs in
  assert (sorted = [("a", 1); ("b", 2); ("c", 3)]);

  let tbl2 = Hashtbl.of_seq (List.to_seq [("x", 10); ("y", 20)]) in
  assert (Hashtbl.find tbl2 "x" = 10);
  assert (Hashtbl.find tbl2 "y" = 20);

  print_endline "Hash table iteration works!"
