type shape = < area : float; describe : string >

let circle r : shape = object
  method area = Float.pi *. r *. r
  method describe = Printf.sprintf "circle(r=%.1f)" r
end

let rectangle w h : shape = object
  method area = w *. h
  method describe = Printf.sprintf "rect(%.1f x %.1f)" w h
end

let print_shape (s : shape) =
  Printf.sprintf "%s: area=%.2f" s#describe s#area

let () =
  let c = circle 5.0 in
  let r = rectangle 3.0 4.0 in

  assert (String.starts_with ~prefix:"circle" (print_shape c));
  assert (Float.abs (c#area -. (Float.pi *. 25.0)) < 0.001);
  assert (print_shape r = "rect(3.0 x 4.0): area=12.00");

  let shapes = [c; r] in
  let total = List.fold_left (fun acc s -> acc +. s#area) 0.0 shapes in
  assert (Float.abs (total -. (Float.pi *. 25.0 +. 12.0)) < 0.001);

  print_endline "Object types work!"
