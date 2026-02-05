(* TODO: Use Option.map and Option.bind *)

let () =
  let some_num = Some 5 in
  let no_num = None in

  let incremented = ??? in (* Use Option.map to add 1 to some_num *)
  assert (incremented = Some 6);

  let still_none = ??? in (* Use Option.map to add 1 to no_num *)
  assert (still_none = None);

  let safe_div x y = if y = 0 then None else Some (x / y) in
  let result = ??? in (* Use Option.bind to chain: Some 10 |> safe_div by 2 *)
  assert (result = Some 5);

  print_endline "Option.map and Option.bind work!"
