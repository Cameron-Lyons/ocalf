let () =
  let some_num = Some 5 in
  let no_num = None in

  let incremented = Option.map (fun x -> x + 1) some_num in
  assert (incremented = Some 6);

  let still_none = Option.map (fun x -> x + 1) no_num in
  assert (still_none = None);

  let safe_div x y = if y = 0 then None else Some (x / y) in
  let result = Option.bind (Some 10) (fun x -> safe_div x 2) in
  assert (result = Some 5);

  print_endline "Option.map and Option.bind work!"
