module StringMap = Map.Make(String)

let () =
  let m = StringMap.of_seq (List.to_seq [("a", 1); ("b", 2); ("c", 3)]) in

  let sum = StringMap.fold (fun _ v acc -> acc + v) m 0 in
  assert (sum = 6);

  let keys = List.rev (StringMap.fold (fun k _ acc -> k :: acc) m []) in
  assert (keys = ["a"; "b"; "c"]);

  let bindings = StringMap.bindings m in
  assert (bindings = [("a", 1); ("b", 2); ("c", 3)]);

  let m2 = StringMap.of_seq (List.to_seq [("b", 20); ("c", 30); ("d", 40)]) in
  let merged = StringMap.union (fun _ v1 v2 -> Some (v1 + v2)) m m2 in
  assert (StringMap.find "a" merged = 1);
  assert (StringMap.find "b" merged = 22);
  assert (StringMap.find "c" merged = 33);
  assert (StringMap.find "d" merged = 40);

  print_endline "Map folding works!"
