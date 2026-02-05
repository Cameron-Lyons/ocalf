let print_hello () =
  print_endline "Hello!"

let do_nothing () = ()

let () =
  let result = print_hello () in
  assert (result = ());
  let nothing = do_nothing () in
  assert (nothing = ());
  print_endline "Unit type understood!"
