type primary = [ `Red | `Green | `Blue ]
type extended = [ primary | `Yellow | `Cyan | `Magenta ]

let primary_to_hex (color : primary) : string =
  match color with
  | `Red -> "#ff0000"
  | `Green -> "#00ff00"
  | `Blue -> "#0000ff"

let extended_to_hex (color : extended) : string =
  match color with
  | #primary as c -> primary_to_hex c
  | `Yellow -> "#ffff00"
  | `Cyan -> "#00ffff"
  | `Magenta -> "#ff00ff"

let () =
  assert (primary_to_hex `Red = "#ff0000");
  assert (extended_to_hex `Red = "#ff0000");
  assert (extended_to_hex `Yellow = "#ffff00");
  assert (extended_to_hex `Cyan = "#00ffff");
  print_endline "Polymorphic variant types work!"
