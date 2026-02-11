(* TODO: Define mutually recursive types and functions *)

type expr =
  | Num of int
  | Add of expr * expr
  | Mul of expr * expr
  | Let of string * expr * expr
  | Var of string

type env = ???  (* A list of (string * int) pairs *)

let rec eval (e : env) : expr -> int = function
  | Num n -> ???  (* Return n *)
  | Add (a, b) -> ???  (* Evaluate both and add *)
  | Mul (a, b) -> ???  (* Evaluate both and multiply *)
  | Let (name, value, body) -> ???  (* Evaluate value, extend env, evaluate body *)
  | Var name -> ???  (* Look up name in env using List.assoc *)

let () =
  let e = [] in
  assert (eval e (Num 42) = 42);
  assert (eval e (Add (Num 2, Num 3)) = 5);
  assert (eval e (Mul (Num 3, Num 4)) = 12);
  assert (eval e (Let ("x", Num 5, Mul (Var "x", Var "x"))) = 25);
  assert (eval e (Let ("x", Num 2, Let ("y", Num 3, Add (Var "x", Var "y")))) = 5);
  assert (eval e (Let ("a", Add (Num 1, Num 2), Mul (Var "a", Var "a"))) = 9);
  print_endline "Expression evaluator works!"
