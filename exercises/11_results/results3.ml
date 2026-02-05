(* TODO: Use Result.map and Result.bind *)

let () =
  let ok_num = Ok 5 in
  let err = Error "failed" in

  let incremented = ??? in (* Use Result.map to add 1 to ok_num *)
  assert (incremented = Ok 6);

  let still_err = ??? in (* Use Result.map to add 1 to err *)
  assert (still_err = Error "failed");

  let safe_div x y =
    if y = 0 then Error "division by zero"
    else Ok (x / y)
  in
  let result = ??? in (* Use Result.bind to chain: Ok 10 |> safe_div by 2 *)
  assert (result = Ok 5);

  print_endline "Result.map and Result.bind work!"
