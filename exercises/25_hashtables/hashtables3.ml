(* TODO: Iterate over hash tables and build them from sequences *)

let () =
  let tbl = Hashtbl.create 16 in
  Hashtbl.add tbl "a" 1;
  Hashtbl.add tbl "b" 2;
  Hashtbl.add tbl "c" 3;

  let sum = ref 0 in
  ???;  (* Use Hashtbl.iter to add all values to sum *)
  assert (!sum = 6);

  let pairs = ???  (* Convert tbl to a list of (key, value) pairs using Hashtbl.to_seq then List.of_seq *)
  in
  let sorted = List.sort (fun (a, _) (b, _) -> String.compare a b) pairs in
  assert (sorted = [("a", 1); ("b", 2); ("c", 3)]);

  let tbl2 = ???  (* Create a hash table from a list of pairs using Hashtbl.of_seq and List.to_seq *)
  in
  assert (Hashtbl.find tbl2 "x" = 10);
  assert (Hashtbl.find tbl2 "y" = 20);

  print_endline "Hash table iteration works!"
