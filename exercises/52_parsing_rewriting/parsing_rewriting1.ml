(* TODO: Implement tokenization and constant folding for a tiny expression language *)

type expr =
  | Int of int
  | Add of expr * expr

type token =
  | INT of int
  | PLUS

let tokenize s =
  s
  |> String.split_on_char ' '
  |> List.filter (fun part -> part <> "")
  |> List.map (function
       | "+" -> PLUS
       | n -> ???)

let parse tokens =
  let rec parse_tail acc = function
    | [] -> acc
    | PLUS :: INT n :: rest -> parse_tail (Add (acc, Int n)) rest
    | _ -> failwith "invalid token sequence"
  in
  match tokens with
  | INT n :: rest -> parse_tail (Int n) rest
  | _ -> failwith "expression must start with an int"

let rec fold_constants = function
  | Int n -> Int n
  | Add (a, b) ->
      let a' = fold_constants a in
      let b' = fold_constants b in
      match (a', b') with
      | Int x, Int y -> ???
      | _ -> Add (a', b')

let () =
  let tokens = tokenize "1 + 2 + 3" in
  let ast = parse tokens in
  let simplified = fold_constants ast in
  match simplified with
  | Int n -> assert (n = 6)
  | _ -> assert false;
  print_endline "Parsing + rewriting works!"
