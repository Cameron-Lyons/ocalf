(* TODO: Define a variant type for traffic light colors *)

type traffic_light = ???  (* Red | Yellow | Green *)

let color_to_string color =
  match color with
  | Red -> "red"
  | Yellow -> "yellow"
  | Green -> "green"

let () =
  assert (color_to_string Red = "red");
  assert (color_to_string Yellow = "yellow");
  assert (color_to_string Green = "green");
  print_endline "Variants work!"
