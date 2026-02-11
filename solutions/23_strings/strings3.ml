let () =
  let csv = "apple,banana,cherry" in

  let parts = String.split_on_char ',' csv in
  assert (parts = ["apple"; "banana"; "cherry"]);

  let joined = String.concat " | " parts in
  assert (joined = "apple | banana | cherry");

  let has_a = String.contains csv 'a' in
  assert (has_a = true);

  let has_z = String.contains csv 'z' in
  assert (has_z = false);

  let starts = String.starts_with ~prefix:"apple" csv in
  assert (starts = true);

  let ends = String.ends_with ~suffix:"cherry" csv in
  assert (ends = true);

  print_endline "String splitting and searching works!"
