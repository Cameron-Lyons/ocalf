(* TODO: Make the pattern matching exhaustive *)

type color = Red | Green | Blue | Yellow

let color_to_hex color =
  match color with
  | Red -> "#FF0000"
  | Green -> "#00FF00"
  (* Add missing cases to make this exhaustive *)

let () =
  assert (color_to_hex Red = "#FF0000");
  assert (color_to_hex Green = "#00FF00");
  assert (color_to_hex Blue = "#0000FF");
  assert (color_to_hex Yellow = "#FFFF00");
  print_endline "Exhaustive pattern matching works!"
