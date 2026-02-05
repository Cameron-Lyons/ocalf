let find_element lst x =
  if List.mem x lst then x
  else raise Not_found

let safe_find lst x =
  try
    Some (find_element lst x)
  with
    Not_found -> None

let () =
  assert (safe_find [1; 2; 3] 2 = Some 2);
  assert (safe_find [1; 2; 3] 5 = None);
  assert (safe_find [] 1 = None);
  print_endline "Exception handling works!"
