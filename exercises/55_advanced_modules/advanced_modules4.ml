(* TODO [Hard]: Unpack first-class modules while folding *)

module type Counter = sig
  val name : string
  val count : int
end

let total mods =
  ???  (* Sum all count fields from packed modules *)

let names_above threshold mods =
  ???  (* Return names whose count >= threshold, preserving order *)

module A = struct
  let name = "alpha"
  let count = 2
end

module B = struct
  let name = "beta"
  let count = 5
end

module C = struct
  let name = "gamma"
  let count = 3
end

let () =
  let mods = [ (module A : Counter); (module B : Counter); (module C : Counter) ] in
  assert (total mods = 10);
  assert (names_above 3 mods = [ "beta"; "gamma" ]);
  print_endline "Advanced modules (first-class modules) works!"
