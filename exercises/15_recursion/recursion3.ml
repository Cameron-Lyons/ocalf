(* TODO: Write a tail-recursive function to sum a list *)

let sum lst =
  let rec aux acc = function
    | [] -> ???
    | x :: xs -> ???
  in
  aux 0 lst

let () =
  assert (sum [] = 0);
  assert (sum [1; 2; 3] = 6);
  assert (sum [1; 2; 3; 4; 5; 6; 7; 8; 9; 10] = 55);
  print_endline "Tail recursion works!"
