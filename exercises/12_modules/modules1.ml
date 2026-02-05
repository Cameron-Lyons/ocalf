(* TODO: Define a module with a value and a function *)

module Math = struct
  let pi = ???  (* Define pi as 3.14159 *)
  let square x = ???  (* Define a function that squares x *)
end

let () =
  assert (Math.pi = 3.14159);
  assert (Math.square 3 = 9);
  assert (Math.square 5 = 25);
  print_endline "Module definition works!"
