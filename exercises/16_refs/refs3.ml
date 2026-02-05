(* TODO: Use a ref for a counter to generate unique IDs *)

let next_id =
  let counter = ref 0 in
  fun () ->
    ???  (* Increment counter and return the new value *)

let () =
  assert (next_id () = 1);
  assert (next_id () = 2);
  assert (next_id () = 3);
  assert (next_id () = 4);
  print_endline "Ref for unique IDs works!"
