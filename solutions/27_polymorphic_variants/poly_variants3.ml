let describe_shape shape =
  match shape with
  | `Circle r -> Printf.sprintf "circle with radius %.1f" r
  | `Rect (w, h) -> Printf.sprintf "rectangle %.1f x %.1f" w h
  | `Point -> "point"

let area shape =
  match shape with
  | `Circle r -> Float.pi *. r *. r
  | `Rect (w, h) -> w *. h
  | `Point -> 0.0

let () =
  assert (describe_shape (`Circle 5.0) = "circle with radius 5.0");
  assert (describe_shape (`Rect (3.0, 4.0)) = "rectangle 3.0 x 4.0");
  assert (describe_shape `Point = "point");

  let a = area (`Circle 1.0) in
  assert (Float.abs (a -. Float.pi) < 0.0001);
  assert (area (`Rect (3.0, 4.0)) = 12.0);
  assert (area `Point = 0.0);

  print_endline "Polymorphic variants with data work!"
