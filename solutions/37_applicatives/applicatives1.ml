module Option_syntax = struct
  let ( let+ ) o f = Option.map f o
end

module Result_syntax = struct
  let ( let+ ) r f = Result.map f r
end

let double_opt (x : int option) : int option =
  let open Option_syntax in
  let+ v = x in v * 2

let string_of_result (r : (int, string) result) : (string, string) result =
  let open Result_syntax in
  let+ v = r in string_of_int v

let () =
  assert (double_opt (Some 5) = Some 10);
  assert (double_opt None = None);

  assert (string_of_result (Ok 42) = Ok "42");
  assert (string_of_result (Error "bad") = Error "bad");

  let open Option_syntax in
  let result =
    let+ x = Some 3 in
    x * x + 1
  in
  assert (result = Some 10);

  print_endline "let+ works!"
