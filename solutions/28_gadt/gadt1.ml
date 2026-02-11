type _ expr =
  | Int : int -> int expr
  | Bool : bool -> bool expr
  | Add : int expr * int expr -> int expr
  | If : bool expr * 'a expr * 'a expr -> 'a expr

let rec eval : type a. a expr -> a = function
  | Int n -> n
  | Bool b -> b
  | Add (a, b) -> eval a + eval b
  | If (cond, then_, else_) -> if eval cond then eval then_ else eval else_

let () =
  assert (eval (Int 42) = 42);
  assert (eval (Bool true) = true);
  assert (eval (Add (Int 2, Int 3)) = 5);
  assert (eval (If (Bool true, Int 1, Int 2)) = 1);
  assert (eval (If (Bool false, Int 1, Int 2)) = 2);
  assert (eval (Add (Int 10, Add (Int 20, Int 30))) = 60);
  print_endline "GADT basics work!"
