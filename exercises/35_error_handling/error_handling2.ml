(* TODO: Chain error-prone operations with Result and let* *)

let ( let* ) = Result.bind

let parse_int s =
  match int_of_string_opt s with
  | Some n -> Ok n
  | None -> Error (Printf.sprintf "not an integer: %s" s)

let check_positive n =
  ???  (* Return Ok n if n > 0, otherwise Error "must be positive" *)

let check_max max n =
  ???  (* Return Ok n if n <= max, otherwise Error "exceeds maximum" *)

let validate_age s =
  ???  (* Use let* to chain: parse_int, check_positive, check_max 150 *)

let validate_all inputs =
  ???  (* Use List.fold_left to validate each input, collecting Ok values into a list.
         Return Ok of the reversed list on success, or the first Error encountered.
         Hint: let* acc = acc_result in let* v = validate_age s in Ok (v :: acc) *)

let () =
  assert (validate_age "25" = Ok 25);
  assert (validate_age "abc" = Error "not an integer: abc");
  assert (validate_age "-5" = Error "must be positive");
  assert (validate_age "200" = Error "exceeds maximum");

  assert (validate_all ["25"; "30"; "18"] = Ok [25; 30; 18]);
  assert (validate_all ["25"; "abc"; "18"] = Error "not an integer: abc");

  print_endline "Error chaining works!"
