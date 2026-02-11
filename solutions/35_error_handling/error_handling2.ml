let ( let* ) = Result.bind

let parse_int s =
  match int_of_string_opt s with
  | Some n -> Ok n
  | None -> Error (Printf.sprintf "not an integer: %s" s)

let check_positive n =
  if n > 0 then Ok n else Error "must be positive"

let check_max max n =
  if n <= max then Ok n else Error "exceeds maximum"

let validate_age s =
  let* n = parse_int s in
  let* n = check_positive n in
  let* n = check_max 150 n in
  Ok n

let validate_all inputs =
  let result =
    List.fold_left
      (fun acc s ->
        let* acc = acc in
        let* v = validate_age s in
        Ok (v :: acc))
      (Ok []) inputs
  in
  Result.map List.rev result

let () =
  assert (validate_age "25" = Ok 25);
  assert (validate_age "abc" = Error "not an integer: abc");
  assert (validate_age "-5" = Error "must be positive");
  assert (validate_age "200" = Error "exceeds maximum");

  assert (validate_all ["25"; "30"; "18"] = Ok [25; 30; 18]);
  assert (validate_all ["25"; "abc"; "18"] = Error "not an integer: abc");

  print_endline "Error chaining works!"
