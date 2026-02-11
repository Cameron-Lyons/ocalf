(* TODO: Use locally abstract types and type constraints *)

let show_any (type a) (show : a -> string) (x : a) : string =
  ???  (* Apply show to x *)

module type Showable = sig
  type t
  val show : t -> string
end

let show_value (type a) (module S : Showable with type t = a) (x : a) : string =
  ???  (* Use S.show to convert x to string *)

module ShowInt : Showable with type t = int = struct
  type t = ???  (* Define type t *)
  let show = ???  (* Convert to string *)
end

module ShowBool : Showable with type t = bool = struct
  type t = ???
  let show = ???  (* Convert to string: "true" or "false" *)
end

let () =
  assert (show_any string_of_int 42 = "42");
  assert (show_any string_of_float 3.14 = "3.14");

  assert (show_value (module ShowInt) 42 = "42");
  assert (show_value (module ShowBool) true = "true");
  assert (show_value (module ShowBool) false = "false");

  let format (type a) (module S : Showable with type t = a) (label : string) (x : a) =
    label ^ ": " ^ S.show x
  in
  assert (format (module ShowInt) "age" 30 = "age: 30");
  assert (format (module ShowBool) "active" true = "active: true");

  print_endline "Type annotations work!"
