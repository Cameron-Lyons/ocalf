let () =
  let some_val = Some 42 in
  let none_val = None in
  let ok_val = Ok 42 in
  let err_val = Error "error" in

  let opt_to_res = Option.to_result ~none:"missing" some_val in
  assert (opt_to_res = Ok 42);

  let none_to_res = Option.to_result ~none:"missing" none_val in
  assert (none_to_res = Error "missing");

  let res_to_opt = Result.to_option ok_val in
  assert (res_to_opt = Some 42);

  let err_to_opt = Result.to_option err_val in
  assert (err_to_opt = None);

  print_endline "Option/Result conversion works!"
