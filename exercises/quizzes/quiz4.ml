(* TODO: Quiz 4 - Strings, Data Structures, and Advanced Types *)

module StringMap = Map.Make(String)

let q1_reverse_words s =
  ???  (* Split s on ' ', reverse the list, join with " " *)

let q2_word_count s =
  let words = String.split_on_char ' ' s in
  ???  (* Use List.fold_left to build a StringMap counting occurrences of each word *)

let q3_fibonacci n =
  ???  (* Use Seq.unfold to generate n Fibonacci numbers, return as a list *)

let q4_describe (value : [ `Int of int | `Str of string | `None ]) =
  ???  (* Match polymorphic variants: `Int n -> "int:N", `Str s -> "str:S", `None -> "none" *)

let q5_memo_fib =
  let cache = Hashtbl.create 16 in
  let rec fib n =
    match Hashtbl.find_opt cache n with
    | Some v -> v
    | None ->
      let v = ???  (* if n <= 1 then n else fib (n-1) + fib (n-2) *)
      in
      Hashtbl.add cache n v;
      v
  in
  fib

let () =
  assert (q1_reverse_words "hello world" = "world hello");
  assert (q1_reverse_words "one two three" = "three two one");

  let counts = q2_word_count "the cat and the dog" in
  assert (StringMap.find "the" counts = 2);
  assert (StringMap.find "cat" counts = 1);

  assert (q3_fibonacci 7 = [0; 1; 1; 2; 3; 5; 8]);

  assert (q4_describe (`Int 42) = "int:42");
  assert (q4_describe (`Str "hi") = "str:hi");
  assert (q4_describe `None = "none");

  assert (q5_memo_fib 10 = 55);
  assert (q5_memo_fib 20 = 6765);

  print_endline "Quiz 4 complete!"
