(* TODO: Use while loops *)

let () =
  let counter = ref 0 in
  let sum = ref 0 in

  (* Use a while loop to sum numbers 1 to 5 *)
  ??? ;

  assert (!sum = 15);

  (* Find the first power of 2 greater than 100 *)
  let n = ref 1 in
  ??? ;

  assert (!n = 128);

  print_endline "While loops work!"
