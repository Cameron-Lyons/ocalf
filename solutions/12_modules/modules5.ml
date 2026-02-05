module Outer = struct
  let x = 1

  module Inner = struct
    let y = 2
    let sum = x + y
  end
end

let () =
  assert (Outer.x = 1);
  assert (Outer.Inner.y = 2);
  assert (Outer.Inner.sum = 3);
  print_endline "Nested modules work!"
