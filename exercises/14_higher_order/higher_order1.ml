(* TODO: Write a function that takes another function as an argument *)

let apply_twice f x =
  ???  (* Apply f to x twice *)

let () =
  assert (apply_twice (fun x -> x + 1) 5 = 7);
  assert (apply_twice (fun x -> x * 2) 3 = 12);
  assert (apply_twice String.uppercase_ascii "hi" = "HI");
  print_endline "Functions as arguments work!"
