let () =
  let tbl = Hashtbl.create 16 in
  Hashtbl.add tbl "x" 10;
  Hashtbl.add tbl "y" 20;
  Hashtbl.add tbl "z" 30;

  Hashtbl.replace tbl "x" 99;
  assert (Hashtbl.find tbl "x" = 99);

  let has_y = Hashtbl.mem tbl "y" in
  assert (has_y = true);

  Hashtbl.remove tbl "y";
  let has_y_after = Hashtbl.mem tbl "y" in
  assert (has_y_after = false);
  assert (Hashtbl.length tbl = 2);

  let w = Hashtbl.find_opt tbl "w" in
  assert (w = None);

  let z = Hashtbl.find_opt tbl "z" in
  assert (z = Some 30);

  print_endline "Hash table operations work!"
