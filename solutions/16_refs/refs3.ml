let next_id =
  let counter = ref 0 in
  fun () ->
    counter := !counter + 1;
    !counter

let () =
  assert (next_id () = 1);
  assert (next_id () = 2);
  assert (next_id () = 3);
  assert (next_id () = 4);
  print_endline "Ref for unique IDs works!"
