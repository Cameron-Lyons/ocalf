type expr =
  | Num of int
  | Add of expr * expr
  | Mul of expr * expr
  | Let of string * expr * expr
  | Var of string

type env = (string * int) list

let rec eval (e : env) : expr -> int = function
  | Num n -> n
  | Add (a, b) -> eval e a + eval e b
  | Mul (a, b) -> eval e a * eval e b
  | Let (name, value, body) -> eval ((name, eval e value) :: e) body
  | Var name -> List.assoc name e

let () =
  let e = [] in
  assert (eval e (Num 42) = 42);
  assert (eval e (Add (Num 2, Num 3)) = 5);
  assert (eval e (Mul (Num 3, Num 4)) = 12);
  assert (eval e (Let ("x", Num 5, Mul (Var "x", Var "x"))) = 25);
  assert (eval e (Let ("x", Num 2, Let ("y", Num 3, Add (Var "x", Var "y")))) = 5);
  assert (eval e (Let ("a", Add (Num 1, Num 2), Mul (Var "a", Var "a"))) = 9);
  print_endline "Expression evaluator works!"
