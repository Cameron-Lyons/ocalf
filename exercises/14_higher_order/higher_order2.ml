(* TODO: Write a function that returns another function *)

let make_multiplier n =
  ???  (* Return a function that multiplies its argument by n *)

let () =
  let times3 = make_multiplier 3 in
  let times10 = make_multiplier 10 in

  assert (times3 4 = 12);
  assert (times3 0 = 0);
  assert (times10 5 = 50);
  print_endline "Functions returning functions work!"
