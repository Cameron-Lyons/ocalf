let describe_list lst =
  match lst with
  | [] -> "empty"
  | [_] -> "one element"
  | [_; _] -> "two elements"
  | _ -> "many elements"

let () =
  assert (describe_list [] = "empty");
  assert (describe_list [1] = "one element");
  assert (describe_list [1; 2] = "two elements");
  assert (describe_list [1; 2; 3] = "many elements");
  print_endline "List pattern matching works!"
