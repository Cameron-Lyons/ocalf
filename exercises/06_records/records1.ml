(* TODO: Define a record type `person` and create a value *)

type person = ???  (* Define a record with name (string) and age (int) fields *)

let alice = ???  (* Create a person record for Alice, age 30 *)

let () =
  assert (alice.name = "Alice");
  assert (alice.age = 30);
  print_endline "Records work!"
