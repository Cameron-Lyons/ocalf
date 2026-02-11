(* TODO: Quiz 6 - Closures, Applicatives, Data Structures, and Types *)

let q1_make_multiplier n =
  ???  (* Return a closure that multiplies its argument by n *)

module Option_syntax = struct
  let ( let+ ) o f = Option.map f o
  let ( and+ ) a b =
    match (a, b) with
    | (Some va, Some vb) -> Some (va, vb)
    | _ -> None
end

let q2_safe_average (a : float option) (b : float option) : float option =
  let open Option_syntax in
  ???  (* Use let+ and and+ to compute the average of a and b *)

let q3_bracket_check s =
  let stack = Stack.create () in
  ???
  (* Iterate over characters of s using String.iter.
     Push opening brackets '(' '[' '{' onto the stack.
     For closing brackets ')' ']' '}', pop and check the match.
     Return true if all brackets match and stack is empty at the end.
     Hint: use try/with to catch Stack.Empty *)

type 'a showable = { value : 'a; show : 'a -> string }

let q4_to_string (s : 'a showable) : string =
  ???  (* Use s.show on s.value *)

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
