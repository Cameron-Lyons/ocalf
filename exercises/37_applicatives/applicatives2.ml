(* TODO: Use and+ for combining multiple optional/result values *)

module Option_syntax = struct
  let ( let+ ) o f = Option.map f o
  let ( and+ ) a b = ???
    (* If both a and b are Some, return Some (va, vb). Otherwise None.
       Hint: match (a, b) with | (Some va, Some vb) -> ... *)
end

module Result_syntax = struct
  let ( let+ ) r f = Result.map f r
  let ( and+ ) a b = ???
    (* If both a and b are Ok, return Ok (va, vb). Otherwise return the first Error. *)
end

let add_opts (a : int option) (b : int option) : int option =
  let open Option_syntax in
  ???  (* Use let+ ... and+ ... to add a and b *)

let make_pair (name : (string, string) result) (age : (int, string) result) :
  (string * int, string) result =
  let open Result_syntax in
  ???  (* Use let+ ... and+ ... to combine name and age into a pair *)

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
