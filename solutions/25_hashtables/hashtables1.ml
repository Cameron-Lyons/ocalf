let () =
  let tbl = Hashtbl.create 16 in

  Hashtbl.add tbl "alice" 30;
  Hashtbl.add tbl "bob" 25;
  Hashtbl.add tbl "carol" 35;

  let alice_age = Hashtbl.find tbl "alice" in
  assert (alice_age = 30);

  let bob_age = Hashtbl.find tbl "bob" in
  assert (bob_age = 25);

  let size = Hashtbl.length tbl in
  assert (size = 3);

  print_endline "Hash table basics work!"
