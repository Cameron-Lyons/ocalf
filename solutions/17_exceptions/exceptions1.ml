let safe_divide a b =
  if b = 0 then
    raise (Invalid_argument "division by zero")
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
