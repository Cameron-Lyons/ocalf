(* TODO: Understand closures - functions that capture their environment *)

let make_greeting prefix =
  ???  (* Return a function that takes a name and returns "prefix, name!" *)

let make_counter () =
  let count = ref 0 in
  ???  (* Return a function that increments count and returns the new value *)

let make_accumulator init =
  let total = ref init in
  let add n = ???  (* Add n to total and return the new total *)
  in
  let get () = ???  (* Return the current total *)
  in
  (add, get)

let () =
  let greet = make_greeting "Hello" in
  assert (greet "Alice" = "Hello, Alice!");
  assert (greet "Bob" = "Hello, Bob!");

  let hi = make_greeting "Hi" in
  assert (hi "Carol" = "Hi, Carol!");

  let next = make_counter () in
  assert (next () = 1);
  assert (next () = 2);
  assert (next () = 3);

  let next2 = make_counter () in
  assert (next2 () = 1);
  assert (next () = 4);

  let (add, get) = make_accumulator 0 in
  add 10;
  add 20;
  assert (get () = 30);

  print_endline "Closures work!"
