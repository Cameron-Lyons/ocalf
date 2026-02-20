module type Counter = sig
  val name : string
  val count : int
end

let total mods =
  List.fold_left
    (fun acc (module M : Counter) -> acc + M.count)
    0 mods

let names_above threshold mods =
  List.fold_left
    (fun acc (module M : Counter) ->
      if M.count >= threshold then acc @ [ M.name ] else acc)
    [] mods

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
