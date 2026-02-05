(* TODO: Work with nested records *)

type address = { street : string; city : string }
type person = { name : string; address : address }

let () =
  let alice = {
    name = "Alice";
    address = ??? (* Create an address: 123 Main St, Boston *)
  } in

  assert (alice.name = "Alice");
  assert (alice.address.street = "123 Main St");
  assert (alice.address.city = "Boston");

  let moved_alice = ??? in (* Update alice to live in New York, same street *)
  assert (moved_alice.address.city = "New York");

  print_endline "Nested records work!"
