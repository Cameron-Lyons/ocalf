(* TODO: Use record field access and update syntax *)

type person = { name : string; age : int }

let () =
  let alice = { name = "Alice"; age = 30 } in

  let name = ??? in (* Access the name field *)
  assert (name = "Alice");

  let older_alice = ??? in (* Create a copy with age = 31 using { ... with ... } *)
  assert (older_alice.name = "Alice");
  assert (older_alice.age = 31);

  print_endline "Record access and update work!"
