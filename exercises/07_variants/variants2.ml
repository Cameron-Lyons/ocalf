(* TODO: Define a variant type with data *)

type shape =
  | Circle of ???     (* radius as float *)
  | Rectangle of ???  (* width and height as float * float *)

let area shape =
  match shape with
  | Circle r -> 3.14159 *. r *. r
  | Rectangle (w, h) -> w *. h

let () =
  let c = Circle 2.0 in
  let r = Rectangle (3.0, 4.0) in
  assert (abs_float (area c -. 12.56636) < 0.001);
  assert (area r = 12.0);
  print_endline "Variants with data work!"
