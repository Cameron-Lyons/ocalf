module StringMap = Map.Make(String)

let () =
  let m = StringMap.empty in
  let m = StringMap.add "alice" 30 m in
  let m = StringMap.add "bob" 25 m in
  let m = StringMap.add "carol" 35 m in

  let alice_age = StringMap.find "alice" m in
  assert (alice_age = 30);

  let size = StringMap.cardinal m in
  assert (size = 3);

  let has_bob = StringMap.mem "bob" m in
  assert (has_bob = true);

  let has_dave = StringMap.mem "dave" m in
  assert (has_dave = false);

  print_endline "Map basics work!"
