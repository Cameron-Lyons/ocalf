(* TODO: Write custom pretty printers *)

type point = { x : float; y : float }

let pp_point fmt p =
  ???  (* Use Format.fprintf to print "(x, y)" with %.1f formatting *)

type shape =
  | Circle of point * float
  | Rect of point * point

let pp_shape fmt = function
  | Circle (center, radius) ->
    ???  (* Format.fprintf fmt "Circle(center=%a, r=%.1f)" using pp_point for center *)
  | Rect (p1, p2) ->
    ???  (* Format.fprintf fmt "Rect(%a, %a)" using pp_point for both points *)

let () =
  let p = { x = 1.0; y = 2.0 } in
  assert (Format.asprintf "%a" pp_point p = "(1.0, 2.0)");

  let c = Circle ({ x = 0.0; y = 0.0 }, 5.0) in
  assert (Format.asprintf "%a" pp_shape c = "Circle(center=(0.0, 0.0), r=5.0)");

  let r = Rect ({ x = 1.0; y = 2.0 }, { x = 3.0; y = 4.0 }) in
  assert (Format.asprintf "%a" pp_shape r = "Rect((1.0, 2.0), (3.0, 4.0))");

  print_endline "Pretty printers work!"
