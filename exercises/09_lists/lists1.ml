(* TODO: Create lists and use the cons operator *)

let numbers = ???  (* Create the list [1; 2; 3] *)
let more_numbers = ???  (* Prepend 0 to numbers using :: *)

let () =
  assert (numbers = [1; 2; 3]);
  assert (more_numbers = [0; 1; 2; 3]);
  assert (List.length numbers = 3);
  print_endline "List creation works!"
