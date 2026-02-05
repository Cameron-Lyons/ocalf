type person = { name : string; age : int }

let () =
  let alice = { name = "Alice"; age = 30 } in

  let name = alice.name in
  assert (name = "Alice");

  let older_alice = { alice with age = 31 } in
  assert (older_alice.name = "Alice");
  assert (older_alice.age = 31);

  print_endline "Record access and update work!"
