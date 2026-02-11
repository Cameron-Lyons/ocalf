module StringSet = Set.Make(String)

let () =
  let words = StringSet.of_list ["apple"; "banana"; "cherry"; "date"] in

  let upper_words = StringSet.map String.uppercase_ascii words in
  assert (StringSet.mem "APPLE" upper_words = true);
  assert (StringSet.mem "apple" upper_words = false);

  let short = StringSet.filter (fun w -> String.length w <= 5) words in
  assert (StringSet.elements short = ["apple"; "date"]);

  let total_len = StringSet.fold (fun w acc -> acc + String.length w) words 0 in
  assert (total_len = 21);

  let has_long = StringSet.exists (fun w -> String.length w > 5) words in
  assert (has_long = true);

  let all_nonempty = StringSet.for_all (fun w -> String.length w > 0) words in
  assert (all_nonempty = true);

  print_endline "Set transformations work!"
