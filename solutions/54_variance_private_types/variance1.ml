type +'a reader = { read : 'a }

let map_reader f r =
  { read = f r.read }

let widen (x : [ `Dog ] reader) : [> `Dog ] reader = x

let () =
  let dog = { read = `Dog } in
  let animal = widen dog in
  let label = map_reader (function `Dog -> "dog") animal in
  assert (label.read = "dog");
  print_endline "Variance (covariance) works!"
