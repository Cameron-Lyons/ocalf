let flatten lsts =
  let rec aux acc = function
    | [] -> List.rev acc
    | [] :: rest -> aux acc rest
    | (x :: xs) :: rest -> aux (x :: acc) (xs :: rest)
  in
  aux [] lsts

let partition pred lst =
  let rec aux yes no = function
    | [] -> (List.rev yes, List.rev no)
    | x :: xs ->
      if pred x then aux (x :: yes) no xs
      else aux yes (x :: no) xs
  in
  aux [] [] lst

let filter_map f lst =
  let rec aux acc = function
    | [] -> List.rev acc
    | x :: xs ->
      match f x with
      | Some v -> aux (v :: acc) xs
      | None -> aux acc xs
  in
  aux [] lst

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
