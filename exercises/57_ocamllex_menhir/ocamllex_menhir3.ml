(* TODO [Medium]: Return parse errors as Result instead of raising *)

type expr =
  | Int of int
  | Add of expr * expr
  | Mul of expr * expr

type token =
  | INT of int
  | PLUS
  | STAR

let rec parse_sum = function
  | INT n :: rest -> parse_sum_tail (Int n) rest
  | _ -> Error "expression must start with INT"

and parse_sum_tail lhs = function
  | [] -> Ok lhs
  | PLUS :: INT n :: rest -> parse_sum_tail (Add (lhs, Int n)) rest
  | STAR :: INT n :: rest -> parse_sum_tail (Mul (lhs, Int n)) rest
  | _ -> ???  (* Return Error with a clear message *)

let rec eval = function
  | Int n -> n
  | Add (a, b) -> eval a + eval b
  | Mul (a, b) -> eval a * eval b

let () =
  assert (parse_sum [ INT 2; PLUS; INT 3 ] = Ok (Add (Int 2, Int 3)));
  assert (parse_sum [ PLUS; INT 3 ] = Error "expression must start with INT");
  match parse_sum [ INT 2; STAR; INT 4; PLUS; INT 1 ] with
  | Ok e -> assert (eval e = 9)
  | Error _ -> assert false;
  print_endline "ocamllex/menhir scaffold 3 works!"
