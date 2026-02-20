(* TODO [Easy]: Mark this immutable reader as covariant and implement map_reader *)

type 'a reader = ???  (* Should expose only read : 'a *)

let map_reader f r =
  ???  (* Apply f to r.read and wrap back into a reader *)

let widen (x : [ `Dog ] reader) : [> `Dog ] reader = x

let () =
  let dog = { read = `Dog } in
  let animal = widen dog in
  let label = map_reader (function `Dog -> "dog") animal in
  assert (label.read = "dog");
  print_endline "Variance (covariance) works!"
