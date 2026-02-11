(* TODO: Create and force lazy values *)

let () =
  let x = ???  (* Create a lazy value that evaluates to 21 * 2 *)
  in
  assert (Lazy.is_val x = false);

  let v = ???  (* Force the lazy value using Lazy.force *)
  in
  assert (v = 42);
  assert (Lazy.is_val x = true);

  let counter = ref 0 in
  let expensive = lazy (incr counter; !counter * 10) in

  let r1 = ???  (* Force expensive *)
  in
  let r2 = ???  (* Force expensive again *)
  in
  assert (r1 = 10);
  assert (r2 = 10);
  assert (!counter = 1);

  print_endline "Lazy values work!"
