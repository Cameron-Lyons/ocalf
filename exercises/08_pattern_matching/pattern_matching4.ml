(* TODO: Use the `as` pattern to bind names *)

let first_or_default lst default =
  match lst with
  | [] -> default
  | (x :: _ as whole) -> ??? (* Return the whole list if it starts with 0, otherwise just x *)

let () =
  assert (first_or_default [] 99 = 99);
  assert (first_or_default [1; 2; 3] 99 = 1);
  print_endline "As patterns work!"
