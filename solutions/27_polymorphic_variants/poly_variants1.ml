let color_to_string color =
  match color with
  | `Red -> "red"
  | `Green -> "green"
  | `Blue -> "blue"

let () =
  assert (color_to_string `Red = "red");
  assert (color_to_string `Green = "green");
  assert (color_to_string `Blue = "blue");
  print_endline "Polymorphic variant basics work!"
