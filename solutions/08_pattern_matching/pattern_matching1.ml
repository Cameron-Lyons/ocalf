type day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday

let is_weekend day =
  match day with
  | Saturday | Sunday -> true
  | _ -> false

let () =
  assert (is_weekend Saturday = true);
  assert (is_weekend Sunday = true);
  assert (is_weekend Monday = false);
  assert (is_weekend Friday = false);
  print_endline "Pattern matching on variants works!"
