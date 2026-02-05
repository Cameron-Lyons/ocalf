(* TODO: Raise exceptions *)

let safe_divide a b =
  if b = 0 then
    ???  (* Raise Invalid_argument with message "division by zero" *)
  else
    a / b

let () =
  assert (safe_divide 10 2 = 5);

  let raised =
    try
      let _ = safe_divide 10 0 in
      false
    with Invalid_argument _ -> true
  in
  assert raised;

  print_endline "Raising exceptions works!"
