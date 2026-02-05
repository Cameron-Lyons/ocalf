(* TODO: Use List.map and List.filter *)

let () =
  let numbers = [1; 2; 3; 4; 5] in

  let doubled = ??? in (* Double each number using List.map *)
  assert (doubled = [2; 4; 6; 8; 10]);

  let evens = ??? in (* Keep only even numbers using List.filter *)
  assert (evens = [2; 4]);

  print_endline "List.map and List.filter work!"
