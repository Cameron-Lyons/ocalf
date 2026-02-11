(* TODO: Transform and fold over sets *)

module StringSet = Set.Make(String)

let () =
  let words = StringSet.of_list ["apple"; "banana"; "cherry"; "date"] in

  let upper_words = ???  (* Use StringSet.map to uppercase all elements *)
  in
  assert (StringSet.mem "APPLE" upper_words = true);
  assert (StringSet.mem "apple" upper_words = false);

  let short = ???  (* Use StringSet.filter to keep words with length <= 5 *)
  in
  assert (StringSet.elements short = ["apple"; "date"]);

  let total_len = ???  (* Use StringSet.fold to sum the lengths of all words *)
  in
  assert (total_len = 21);

  let has_long = ???  (* Use StringSet.exists to check if any word has length > 5 *)
  in
  assert (has_long = true);

  let all_nonempty = ???  (* Use StringSet.for_all to check all words are non-empty *)
  in
  assert (all_nonempty = true);

  print_endline "Set transformations work!"
