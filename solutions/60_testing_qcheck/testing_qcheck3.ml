let rec shrink_fail ~pred ~shrink x =
  match shrink x with
  | Some x' when not (pred x') -> shrink_fail ~pred ~shrink x'
  | _ -> x

let find_counterexample ~trials ~gen ~pred ~shrink =
  let rec loop i =
    if i >= trials then None
    else
      let v = gen i in
      if pred v then loop (i + 1)
      else Some (shrink_fail ~pred ~shrink v)
  in
  loop 0

let () =
  let pred x = (x * x) <= 100 in
  let gen i = i in
  let shrink x = if x > 0 then Some (x - 1) else None in
  assert (find_counterexample ~trials:30 ~gen ~pred ~shrink = Some 11);
  assert (find_counterexample ~trials:10 ~gen ~pred ~shrink = None);
  print_endline "Testing scaffold 3 works!"
