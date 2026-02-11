(* TODO: Update, remove, and check membership in hash tables *)

let () =
  let tbl = Hashtbl.create 16 in
  Hashtbl.add tbl "x" 10;
  Hashtbl.add tbl "y" 20;
  Hashtbl.add tbl "z" 30;

  ???;  (* Replace the value for "x" with 99 using Hashtbl.replace *)
  assert (Hashtbl.find tbl "x" = 99);

  let has_y = ???  (* Check if "y" exists using Hashtbl.mem *)
  in
  assert (has_y = true);

  ???;  (* Remove "y" from the table using Hashtbl.remove *)
  let has_y_after = ???  (* Check if "y" exists now *)
  in
  assert (has_y_after = false);
  assert (Hashtbl.length tbl = 2);

  let w = ???  (* Use Hashtbl.find_opt to look up "w" which doesn't exist *)
  in
  assert (w = None);

  let z = ???  (* Use Hashtbl.find_opt to look up "z" *)
  in
  assert (z = Some 30);

  print_endline "Hash table operations work!"
