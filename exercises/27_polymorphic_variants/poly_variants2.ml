(* TODO: Use polymorphic variants with data and type constraints *)

type primary = [ `Red | `Green | `Blue ]
type extended = [ primary | `Yellow | `Cyan | `Magenta ]

let primary_to_hex (color : primary) : string =
  match color with
  | ???  (* Match `Red and return "#ff0000" *)
  | ???  (* Match `Green and return "#00ff00" *)
  | ???  (* Match `Blue and return "#0000ff" *)

let extended_to_hex (color : extended) : string =
  match color with
  | ???  (* Use the # type pattern to delegate primary colors to primary_to_hex *)
  | ???  (* Match `Yellow and return "#ffff00" *)
  | ???  (* Match `Cyan and return "#00ffff" *)
  | ???  (* Match `Magenta and return "#ff00ff" *)

let () =
  assert (primary_to_hex `Red = "#ff0000");
  assert (extended_to_hex `Red = "#ff0000");
  assert (extended_to_hex `Yellow = "#ffff00");
  assert (extended_to_hex `Cyan = "#00ffff");
  print_endline "Polymorphic variant types work!"
