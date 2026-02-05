(* TODO: Use mutable record fields *)

type counter = { mutable count : int }

let () =
  let c = { count = 0 } in

  ??? ; (* Increment c.count by 1 *)
  assert (c.count = 1);

  ??? ; (* Increment c.count by 1 again *)
  assert (c.count = 2);

  print_endline "Mutable records work!"
