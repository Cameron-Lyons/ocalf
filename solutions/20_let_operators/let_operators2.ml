module Result_syntax = struct
  let ( let* ) = Result.bind
  let return x = Ok x
end

let parse_int s =
  match int_of_string_opt s with
  | Some n -> Ok n
  | None -> Error ("Invalid integer: " ^ s)

let validate_positive n = if n > 0 then Ok n else Error "Must be positive"

let parse_and_validate s =
  let open Result_syntax in
  let* n = parse_int s in
  let* valid = validate_positive n in
  return valid

let () =
  assert (parse_and_validate "42" = Ok 42);
  assert (parse_and_validate "-5" = Error "Must be positive");
  assert (parse_and_validate "abc" = Error "Invalid integer: abc");
  print_endline "let* for Result works!"
