(* TODO: Fix the scoping issue *)

let () =
  let result =
    let x = 5 in
    let y = 3 in
    (* The result should be x + y, but there's a scoping issue *)
    x + y
  in
  (* Make this assertion pass by fixing the code above *)
  assert (result = ???);
  print_endline "Scoping understood!"
