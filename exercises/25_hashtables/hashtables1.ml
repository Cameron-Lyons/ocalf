(* TODO: Create and use hash tables *)

let () =
  let tbl = ???  (* Create a hash table with initial size 16 using Hashtbl.create *)
  in

  ???;  (* Add key "alice" with value 30 using Hashtbl.add *)
  ???;  (* Add key "bob" with value 25 *)
  ???;  (* Add key "carol" with value 35 *)

  let alice_age = ???  (* Find "alice" in the table using Hashtbl.find *)
  in
  assert (alice_age = 30);

  let bob_age = ???  (* Find "bob" *)
  in
  assert (bob_age = 25);

  let size = ???  (* Get the number of bindings using Hashtbl.length *)
  in
  assert (size = 3);

  print_endline "Hash table basics work!"
