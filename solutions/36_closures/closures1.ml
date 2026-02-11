let make_greeting prefix =
  fun name -> prefix ^ ", " ^ name ^ "!"

let make_counter () =
  let count = ref 0 in
  fun () -> incr count; !count

let make_accumulator init =
  let total = ref init in
  let add n = total := !total + n in
  let get () = !total in
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
