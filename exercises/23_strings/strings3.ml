(* TODO: Split, join, and search strings *)

let () =
  let csv = "apple,banana,cherry" in

  let parts = ???  (* Split csv on ',' using String.split_on_char *)
  in
  assert (parts = ["apple"; "banana"; "cherry"]);

  let joined = ???  (* Join parts back with " | " using String.concat *)
  in
  assert (joined = "apple | banana | cherry");

  let has_a = ???  (* Check if csv contains 'a' using String.contains *)
  in
  assert (has_a = true);

  let has_z = ???  (* Check if csv contains 'z' *)
  in
  assert (has_z = false);

  let starts = ???  (* Check if csv starts with "apple" using String.starts_with *)
  in
  assert (starts = true);

  let ends = ???  (* Check if csv ends with "cherry" using String.ends_with *)
  in
  assert (ends = true);

  print_endline "String splitting and searching works!"
