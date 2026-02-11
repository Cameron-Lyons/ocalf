(* TODO: Use let+ for functor-style mapping over Option and Result *)

module Option_syntax = struct
  let ( let+ ) o f = ???  (* Map f over o using Option.map *)
end

module Result_syntax = struct
  let ( let+ ) r f = ???  (* Map f over r using Result.map *)
end

let double_opt (x : int option) : int option =
  let open Option_syntax in
  ???  (* Use let+ to double the value inside the option *)

let string_of_result (r : (int, string) result) : (string, string) result =
  let open Result_syntax in
  ???  (* Use let+ to convert the Ok value to a string with string_of_int *)

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
