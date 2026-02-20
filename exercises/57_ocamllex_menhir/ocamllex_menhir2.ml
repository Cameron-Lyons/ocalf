(* TODO [Medium]: Parse with precedence: * binds tighter than + *)

type expr =
  | Int of int
  | Add of expr * expr
  | Mul of expr * expr

type token =
  | INT of int
  | PLUS
  | STAR
  | LPAREN
  | RPAREN

let rec parse_factor = function
  | INT n :: rest -> (Int n, rest)
  | LPAREN :: rest ->
      let e, rest' = parse_expr rest in
      (match rest' with
      | RPAREN :: rest'' -> (e, rest'')
      | _ -> failwith "expected )")
  | _ -> failwith "expected factor"

and parse_term tokens =
  let lhs, rest = parse_factor tokens in
  parse_term_tail lhs rest

and parse_term_tail lhs tokens =
  match tokens with
  | STAR :: rest ->
      let rhs, rest' = parse_factor rest in
      ???  (* Continue with Mul (lhs, rhs) *)
  | _ -> (lhs, tokens)

and parse_expr tokens =
  let lhs, rest = parse_term tokens in
  parse_expr_tail lhs rest

and parse_expr_tail lhs tokens =
  match tokens with
  | PLUS :: rest ->
      let rhs, rest' = parse_term rest in
      ???  (* Continue with Add (lhs, rhs) *)
  | _ -> (lhs, tokens)

let parse_complete tokens =
  let e, rest = parse_expr tokens in
  match rest with
  | [] -> e
  | _ -> failwith "trailing tokens"

let rec eval = function
  | Int n -> n
  | Add (a, b) -> eval a + eval b
  | Mul (a, b) -> eval a * eval b

let () =
  let ast = parse_complete [ INT 1; PLUS; INT 2; STAR; INT 3; PLUS; INT 4 ] in
  assert (eval ast = 11);
  print_endline "ocamllex/menhir scaffold 2 works!"
