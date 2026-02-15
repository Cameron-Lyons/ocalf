(* TODO: Parse simple assignments and apply algebraic simplification rewrites *)

type expr =
  | Int of int
  | Var of string
  | Add of expr * expr

type stmt = Assign of string * expr

let parse_assignment s =
  match String.split_on_char '=' s with
  | [ lhs; rhs ] ->
      let var = String.trim lhs in
      let parts = rhs |> String.trim |> String.split_on_char ' ' |> List.filter ((<>) "") in
      (match parts with
       | [ a; "+"; b ] ->
           let atom x =
             match int_of_string_opt x with
             | Some n -> Int n
             | None -> Var x
           in
           Assign (var, Add (atom a, atom b))
       | _ -> failwith "expected: name = a + b")
  | _ -> failwith "expected one '='"

let rec simplify = function
  | Add (Int 0, e) -> e
  | Add (e, Int 0) -> e
  | Add (Int a, Int b) -> Int (a + b)
  | Add (a, b) ->
      let a' = simplify a in
      let b' = simplify b in
      (match (a', b') with
       | Int 0, e -> e
       | e, Int 0 -> e
       | Int x, Int y -> Int (x + y)
       | _ -> ???)
  | e -> e

let simplify_stmt (Assign (name, rhs)) =
  Assign (name, simplify rhs)

let () =
  let s1 = parse_assignment "x = 0 + y" |> simplify_stmt in
  let s2 = parse_assignment "z = 2 + 3" |> simplify_stmt in
  (match s1 with Assign ("x", Var "y") -> () | _ -> assert false);
  (match s2 with Assign ("z", Int 5) -> () | _ -> assert false);
  print_endline "Assignment parsing + rewriting works!"
