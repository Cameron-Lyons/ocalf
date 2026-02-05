module type Counter = sig
  type t
  val create : int -> t
  val increment : t -> t
  val value : t -> int
end

module Counter : Counter = struct
  type t = int
  let create n = n
  let increment c = c + 1
  let value c = c
end

let () =
  let c = Counter.create 0 in
  let c = Counter.increment c in
  let c = Counter.increment c in
  assert (Counter.value c = 2);
  print_endline "Abstract types work!"
