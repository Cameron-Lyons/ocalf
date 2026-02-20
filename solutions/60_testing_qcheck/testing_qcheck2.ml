type 'a prop_result =
  | Pass
  | Fail of
      {
        trial : int;
        value : 'a;
      }

let check_forall ~trials ~gen ~pred =
  let rec loop i =
    if i >= trials then Pass
    else
      let v = gen i in
      if pred v then loop (i + 1)
      else Fail { trial = i; value = v }
  in
  loop 0

let () =
  let r1 = check_forall ~trials:20 ~gen:(fun i -> i) ~pred:(fun x -> x >= 0) in
  assert (r1 = Pass);

  let r2 = check_forall ~trials:20 ~gen:(fun i -> i - 5) ~pred:(fun x -> x >= 0) in
  assert (r2 = Fail { trial = 0; value = -5 });
  print_endline "Testing scaffold 2 works!"
