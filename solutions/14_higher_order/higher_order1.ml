let apply_twice f x =
  f (f x)

let () =
  assert (apply_twice (fun x -> x + 1) 5 = 7);
  assert (apply_twice (fun x -> x * 2) 3 = 12);
  assert (apply_twice String.uppercase_ascii "hi" = "HI");
  print_endline "Functions as arguments work!"
