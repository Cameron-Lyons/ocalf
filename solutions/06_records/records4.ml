type address = { street : string; city : string }
type person = { name : string; address : address }

let () =
  let alice = {
    name = "Alice";
    address = { street = "123 Main St"; city = "Boston" }
  } in

  assert (alice.name = "Alice");
  assert (alice.address.street = "123 Main St");
  assert (alice.address.city = "Boston");

  let moved_alice = { alice with address = { alice.address with city = "New York" } } in
  assert (moved_alice.address.city = "New York");

  print_endline "Nested records work!"
