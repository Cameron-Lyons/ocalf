(* TODO: Create and match on polymorphic variants *)

let color_to_string color =
  match color with
  | ???  (* Match `Red and return "red" *)
  | ???  (* Match `Green and return "green" *)
  | ???  (* Match `Blue and return "blue" *)

let () =
  assert (color_to_string `Red = "red");
  assert (color_to_string `Green = "green");
  assert (color_to_string `Blue = "blue");
  print_endline "Polymorphic variant basics work!"
