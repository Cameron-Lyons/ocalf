module Base = struct
  type t = { id : int; name : string }

  let version = 1
  let make id name = { id; name }
  let render x = Printf.sprintf "v%d#%d:%s" version x.id x.name
  let rename x name = { x with name }
end

module type BASE = module type of Base

module Copy : BASE = struct
  type t = { id : int; name : string }

  let version = 1
  let make id name = { id; name }
  let render x = Printf.sprintf "v%d#%d:%s" version x.id x.name
  let rename x name = { x with name }
end

module Prefixed (M : BASE) = struct
  let render_with_prefix prefix x = prefix ^ M.render x
end

module P = Prefixed (Copy)

let () =
  let u = Copy.make 7 "ann" in
  let u2 = Copy.rename u "bob" in
  assert (Copy.render u2 = "v1#7:bob");
  assert (P.render_with_prefix ">>" u2 = ">>v1#7:bob");
  print_endline "Advanced modules (module type of) works!"
