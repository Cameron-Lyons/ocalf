let safe_div a b : (int, string) result =
  if b = 0 then Error "division by zero" else Ok (a / b)

let safe_head lst : 'a option =
  match lst with [] -> None | x :: _ -> Some x

let option_to_result ~(msg : string) (opt : 'a option) : ('a, string) result =
  match opt with Some x -> Ok x | None -> Error msg

let result_to_option (res : ('a, _) result) : 'a option =
  match res with Ok x -> Some x | Error _ -> None

let safe_parse (s : string) : (int, string) result =
  match int_of_string_opt s with Some n -> Ok n | None -> Error "parse error"

let () =
  assert (safe_div 10 2 = Ok 5);
  assert (safe_div 10 0 = Error "division by zero");

  assert (safe_head [1; 2; 3] = Some 1);
  assert (safe_head [] = None);

  assert (option_to_result ~msg:"missing" (Some 42) = Ok 42);
  assert (option_to_result ~msg:"missing" None = Error "missing");

  assert (result_to_option (Ok 42) = Some 42);
  assert (result_to_option (Error "e") = None);

  assert (safe_parse "42" = Ok 42);
  assert (safe_parse "abc" = Error "parse error");

  print_endline "Error handling conversions work!"
