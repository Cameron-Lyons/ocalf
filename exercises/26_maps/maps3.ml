(* TODO: Fold over maps and convert to/from lists *)

module StringMap = Map.Make(String)

let () =
  let m = StringMap.of_seq (List.to_seq [("a", 1); ("b", 2); ("c", 3)]) in

  let sum = ???  (* Use StringMap.fold to sum all values. fold f map init applies f key value acc *)
  in
  assert (sum = 6);

  let keys = ???  (* Use StringMap.fold to collect all keys into a list (reversed is fine, then List.rev) *)
  in
  assert (keys = ["a"; "b"; "c"]);

  let bindings = ???  (* Use StringMap.bindings to get all (key, value) pairs as a list *)
  in
  assert (bindings = [("a", 1); ("b", 2); ("c", 3)]);

  let m2 = StringMap.of_seq (List.to_seq [("b", 20); ("c", 30); ("d", 40)]) in
  let merged = ???
    (* Use StringMap.union to merge m and m2.
       The function receives key, v1, v2 and returns Some of the value to keep.
       Keep the sum of both values when keys overlap. *)
  in
  assert (StringMap.find "a" merged = 1);
  assert (StringMap.find "b" merged = 22);
  assert (StringMap.find "c" merged = 33);
  assert (StringMap.find "d" merged = 40);

  print_endline "Map folding works!"
