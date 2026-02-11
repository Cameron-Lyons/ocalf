let q1_make_multiplier n =
  fun x -> n * x

module Option_syntax = struct
  let ( let+ ) o f = Option.map f o
  let ( and+ ) a b =
    match (a, b) with
    | (Some va, Some vb) -> Some (va, vb)
    | _ -> None
end

let q2_safe_average (a : float option) (b : float option) : float option =
  let open Option_syntax in
  let+ x = a and+ y = b in (x +. y) /. 2.0

let q3_bracket_check s =
  let stack = Stack.create () in
  let matching = function
    | ')' -> '('
    | ']' -> '['
    | '}' -> '{'
    | _ -> ' '
  in
  try
    String.iter (fun c ->
      match c with
      | '(' | '[' | '{' -> Stack.push c stack
      | ')' | ']' | '}' ->
        let top = Stack.pop stack in
        if top <> matching c then raise Exit
      | _ -> ())
      s;
    Stack.is_empty stack
  with
  | Exit | Stack.Empty -> false

type 'a showable = { value : 'a; show : 'a -> string }

let q4_to_string (s : 'a showable) : string =
  s.show s.value

let () =
  let triple = q1_make_multiplier 3 in
  assert (triple 5 = 15);
  assert (triple 0 = 0);
  let double = q1_make_multiplier 2 in
  assert (double 7 = 14);

  assert (q2_safe_average (Some 4.0) (Some 6.0) = Some 5.0);
  assert (q2_safe_average (Some 4.0) None = None);

  assert (q3_bracket_check "([]){}" = true);
  assert (q3_bracket_check "([)]" = false);
  assert (q3_bracket_check "(((" = false);
  assert (q3_bracket_check "" = true);

  assert (q4_to_string { value = 42; show = string_of_int } = "42");
  assert (q4_to_string { value = true; show = string_of_bool } = "true");

  print_endline "Quiz 6 complete!"
