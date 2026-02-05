module type Adder = sig
  val add : int -> int -> int
end

let use_adder (module A : Adder) x y =
  A.add x y

module RegularAdder = struct
  let add x y = x + y
end

module DoubleAdder = struct
  let add x y = (x + y) * 2
end

let () =
  let result1 = use_adder (module RegularAdder) 2 3 in
  assert (result1 = 5);

  let result2 = use_adder (module DoubleAdder) 2 3 in
  assert (result2 = 10);

  print_endline "First-class modules work!"
