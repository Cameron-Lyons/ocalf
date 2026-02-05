let first_or_default lst default =
  match lst with
  | [] -> default
  | (x :: _ as _whole) -> x

let () =
  assert (first_or_default [] 99 = 99);
  assert (first_or_default [1; 2; 3] 99 = 1);
  print_endline "As patterns work!"
