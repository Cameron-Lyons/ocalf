(* TODO: Convert between Option and Result *)

let () =
  let some_val = Some 42 in
  let none_val = None in
  let ok_val = Ok 42 in
  let err_val = Error "error" in

  let opt_to_res = ??? in (* Convert some_val to Result with error "missing" *)
  assert (opt_to_res = Ok 42);

  let none_to_res = ??? in (* Convert none_val to Result with error "missing" *)
  assert (none_to_res = Error "missing");

  let res_to_opt = ??? in (* Convert ok_val to Option *)
  assert (res_to_opt = Some 42);

  let err_to_opt = ??? in (* Convert err_val to Option *)
  assert (err_to_opt = None);

  print_endline "Option/Result conversion works!"
