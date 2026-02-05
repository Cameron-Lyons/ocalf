(* TODO: Create a module with an abstract type *)

module type Counter = sig
  type t
  val create : int -> t
  val increment : t -> t
  val value : t -> int
end

module Counter : Counter = struct
  type t = ???  (* Define the internal representation *)
  let create n = ???
  let increment c = ???
  let value c = ???
end

let () =
  let c = Counter.create 0 in
  let c = Counter.increment c in
  let c = Counter.increment c in
  assert (Counter.value c = 2);
  print_endline "Abstract types work!"
