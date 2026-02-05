let () =
  let ok_num = Ok 5 in
  let err = Error "failed" in

  let incremented = Result.map (fun x -> x + 1) ok_num in
  assert (incremented = Ok 6);

  let still_err = Result.map (fun x -> x + 1) err in
  assert (still_err = Error "failed");

  let safe_div x y =
    if y = 0 then Error "division by zero"
    else Ok (x / y)
  in
  let result = Result.bind (Ok 10) (fun x -> safe_div x 2) in
  assert (result = Ok 5);

  print_endline "Result.map and Result.bind work!"
