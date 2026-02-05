module Math = struct
  let pi = 3.14159
  let square x = x * x
end

let () =
  assert (Math.pi = 3.14159);
  assert (Math.square 3 = 9);
  assert (Math.square 5 = 25);
  print_endline "Module definition works!"
