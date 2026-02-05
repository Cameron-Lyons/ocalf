type person = { name : string; age : int }

let alice = { name = "Alice"; age = 30 }

let () =
  assert (alice.name = "Alice");
  assert (alice.age = 30);
  print_endline "Records work!"
