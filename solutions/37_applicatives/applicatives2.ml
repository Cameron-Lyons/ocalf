module Option_syntax = struct
  let ( let+ ) o f = Option.map f o
  let ( and+ ) a b =
    match (a, b) with
    | (Some va, Some vb) -> Some (va, vb)
    | _ -> None
end

module Result_syntax = struct
  let ( let+ ) r f = Result.map f r
  let ( and+ ) a b =
    match (a, b) with
    | (Ok va, Ok vb) -> Ok (va, vb)
    | (Error e, _) -> Error e
    | (_, Error e) -> Error e
end

let add_opts (a : int option) (b : int option) : int option =
  let open Option_syntax in
  let+ x = a and+ y = b in x + y

let make_pair (name : (string, string) result) (age : (int, string) result) :
  (string * int, string) result =
  let open Result_syntax in
  let+ n = name and+ a = age in (n, a)

let () =
  assert (add_opts (Some 3) (Some 4) = Some 7);
  assert (add_opts (Some 3) None = None);
  assert (add_opts None (Some 4) = None);

  assert (make_pair (Ok "Alice") (Ok 30) = Ok ("Alice", 30));
  assert (make_pair (Error "no name") (Ok 30) = Error "no name");
  assert (make_pair (Ok "Alice") (Error "no age") = Error "no age");

  let open Option_syntax in
  let result =
    let+ x = Some 2
    and+ y = Some 3
    and+ z = Some 4 in
    x + y + z
  in
  assert (result = Some 9);

  print_endline "and+ works!"
