(* TODO: Create nested modules *)

module Outer = struct
  let x = 1

  module Inner = struct
    let y = ???  (* Set to 2 *)
    let sum = ???  (* Set to x + y = 3 *)
  end
end

let () =
  assert (Outer.x = 1);
  assert (Outer.Inner.y = 2);
  assert (Outer.Inner.sum = 3);
  print_endline "Nested modules work!"
