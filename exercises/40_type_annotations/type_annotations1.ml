(* TODO: Define type aliases and parameterized types *)

type name = ???  (* Define as an alias for string *)
type age = ???  (* Define as an alias for int *)

type 'a pair = ???  (* A tuple of two values of the same type *)

type ('a, 'b) either =
  | ???  (* Left of 'a *)
  | ???  (* Right of 'b *)

let swap_pair (p : 'a pair) : 'a pair =
  ???  (* Swap the two elements of the pair *)

let map_either ~(left : 'a -> 'c) ~(right : 'b -> 'd) (e : ('a, 'b) either) : ('c, 'd) either =
  ???  (* Apply left to Left values, right to Right values *)

let () =
  let n : name = "Alice" in
  let a : age = 30 in
  assert (n = "Alice");
  assert (a = 30);

  let p : int pair = (1, 2) in
  assert (swap_pair p = (2, 1));

  let sp : string pair = ("hello", "world") in
  assert (swap_pair sp = ("world", "hello"));

  assert (map_either ~left:string_of_int ~right:int_of_string (Left 42) = Left "42");
  assert (map_either ~left:string_of_int ~right:int_of_string (Right "99") = Right 99);

  print_endline "Type aliases work!"
