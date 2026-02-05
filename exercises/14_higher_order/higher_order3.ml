(* TODO: Use the pipe operator |> and application operator @@ *)

let add1 x = x + 1
let double x = x * 2
let square x = x * x

let () =
  let result1 = ???  (* Use |> to compute: 5 -> add1 -> double -> square = 144 *)
  assert (result1 = 144);

  let result2 = ???  (* Use @@ to compute: square (double (add1 2)) = 36 *)
  assert (result2 = 36);

  print_endline "Composition operators work!"
