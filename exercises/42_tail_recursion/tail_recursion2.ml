(* TODO: Tail-recursive flatten and partition *)

let flatten lsts =
  ???
  (* Tail-recursively flatten a list of lists.
     Use an inner aux that processes each sublist,
     and an outer loop that processes the list of lists.
     Hint: reverse at the end. *)

let partition pred lst =
  ???
  (* Tail-recursively split lst into (yes, no) where
     yes = elements satisfying pred, no = elements not satisfying pred.
     Both lists should maintain original order. *)

let filter_map f lst =
  ???
  (* Tail-recursively apply f to each element.
     f returns an option - keep Some values, discard None.
     Maintain original order. *)

let () =
  assert (flatten [[1; 2]; [3]; []; [4; 5; 6]] = [1; 2; 3; 4; 5; 6]);
  assert (flatten [] = []);
  assert (flatten [[]; []; []] = []);

  let big = List.init 100_000 (fun i -> [i; i + 1]) in
  ignore (flatten big);

  assert (partition (fun x -> x mod 2 = 0) [1; 2; 3; 4; 5] = ([2; 4], [1; 3; 5]));
  assert (partition (fun _ -> true) [1; 2; 3] = ([1; 2; 3], []));

  assert (filter_map (fun x -> if x > 0 then Some (x * 10) else None) [-1; 2; -3; 4]
          = [20; 40]);
  assert (filter_map int_of_string_opt ["1"; "abc"; "3"] = [1; 3]);

  print_endline "Tail-recursive algorithms work!"
