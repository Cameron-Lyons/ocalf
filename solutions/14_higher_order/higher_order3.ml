let add1 x = x + 1
let double x = x * 2
let square x = x * x

let () =
  let result1 = 5 |> add1 |> double |> square in
  assert (result1 = 144);

  let result2 = square @@ double @@ add1 2 in
  assert (result2 = 36);

  print_endline "Composition operators work!"
