let () =
  let point = object
    val x = 3.0
    val y = 4.0
    method get_x = x
    method get_y = y
    method distance_to_origin = Float.sqrt (x *. x +. y *. y)
  end
  in

  assert (point#get_x = 3.0);
  assert (point#get_y = 4.0);
  assert (point#distance_to_origin = 5.0);

  print_endline "Immediate objects work!"
