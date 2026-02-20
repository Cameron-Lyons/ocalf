(* TODO [Hard]: Add a constant-folding rewrite pass and compose pipeline stages *)

type expr =
  | Int of int
  | Add of expr * expr
  | Mul of expr * expr

type token =
  | INT of int
  | PLUS
  | STAR

let tokenize s =
  s
  |> String.split_on_char ' '
  |> List.filter (fun part -> part <> "")
  |> List.map (function
       | "+" -> PLUS
       | "*" -> STAR
       | n -> INT (int_of_string n))

let parse tokens =
  let rec go acc = function
    | [] -> acc
    | PLUS :: INT n :: rest -> go (Add (acc, Int n)) rest
    | STAR :: INT n :: rest -> go (Mul (acc, Int n)) rest
    | _ -> failwith "invalid token sequence"
  in
  match tokens with
  | INT n :: rest -> go (Int n) rest
  | _ -> failwith "expression must start with INT"

let rec fold_constants = function
  | Int n -> Int n
  | Add (a, b) ->
      let a' = fold_constants a in
      let b' = fold_constants b in
      (match (a', b') with
      | Int 0, e | e, Int 0 -> ???
      | Int x, Int y -> Int (x + y)
      | _ -> Add (a', b'))
  | Mul (a, b) ->
      let a' = fold_constants a in
      let b' = fold_constants b in
      (match (a', b') with
      | Int 0, _ | _, Int 0 -> Int 0
      | Int 1, e | e, Int 1 -> ???
      | Int x, Int y -> Int (x * y)
      | _ -> Mul (a', b'))

let rec eval = function
  | Int n -> n
  | Add (a, b) -> eval a + eval b
  | Mul (a, b) -> eval a * eval b

let run s =
  s |> tokenize |> parse |> fold_constants |> eval

let () =
  assert (run "0 + 3 + 4" = 7);
  assert (run "2 * 1 * 5" = 10);
  assert (run "2 * 3 + 4" = 10);
  print_endline "ocamllex/menhir scaffold 4 works!"
