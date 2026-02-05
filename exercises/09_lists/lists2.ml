(* TODO: Pattern match on lists *)

let describe_list lst =
  match lst with
  | ??? -> "empty"
  | ??? -> "one element"
  | ??? -> "two elements"
  | ??? -> "many elements"

let () =
  assert (describe_list [] = "empty");
  assert (describe_list [1] = "one element");
  assert (describe_list [1; 2] = "two elements");
  assert (describe_list [1; 2; 3] = "many elements");
  print_endline "List pattern matching works!"
