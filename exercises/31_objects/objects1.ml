(* TODO: Create and use immediate objects *)

let () =
  let point = object
    val x = ???  (* Set x to 3.0 *)
    val y = ???  (* Set y to 4.0 *)
    method get_x = ???  (* Return x *)
    method get_y = ???  (* Return y *)
    method distance_to_origin = ???  (* Return sqrt(x^2 + y^2) *)
  end
  in

  assert (point#get_x = 3.0);
  assert (point#get_y = 4.0);
  assert (point#distance_to_origin = 5.0);

  print_endline "Immediate objects work!"
