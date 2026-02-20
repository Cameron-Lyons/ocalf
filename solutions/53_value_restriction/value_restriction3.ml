let make_cell () = ref None

let set_if_empty r x =
  match !r with
  | None -> r := Some x
  | Some _ -> ()

let get_or r ~default =
  match !r with
  | Some x -> x
  | None ->
      let x = default () in
      r := Some x;
      x

let () =
  let int_cell = make_cell () in
  let string_cell = make_cell () in

  set_if_empty int_cell 10;
  set_if_empty int_cell 99;
  set_if_empty string_cell "hi";

  assert (!int_cell = Some 10);
  assert (!string_cell = Some "hi");
  assert (get_or int_cell ~default:(fun () -> 0) = 10);
  assert (get_or string_cell ~default:(fun () -> "fallback") = "hi");
  print_endline "Value restriction (thunked refs) works!"
