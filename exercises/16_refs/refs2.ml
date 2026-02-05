(* TODO: Update a ref *)

let () =
  let counter = ref 0 in

  ??? ; (* Increment counter by 1 *)
  assert (!counter = 1);

  ??? ; (* Set counter to 10 *)
  assert (!counter = 10);

  ??? ; (* Double the current value of counter *)
  assert (!counter = 20);

  print_endline "Ref updates work!"
