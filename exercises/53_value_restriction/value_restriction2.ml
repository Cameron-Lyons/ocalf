(* TODO [Medium]: Build polymorphic operations using record fields with explicit universal quantification *)

type poly_ops =
  {
    id : 'a. 'a -> 'a;
    pair : 'a. 'a -> 'a * 'a;
  }

let ops = ???  (* Provide both id and pair *)

let apply_twice (f : 'a -> 'a) (x : 'a) =
  f (f x)

let () =
  assert (ops.id 42 = 42);
  assert (ops.id "ocaml" = "ocaml");
  assert (ops.pair true = (true, true));
  assert (ops.pair "x" = ("x", "x"));
  assert (apply_twice ops.id 5 = 5);
  print_endline "Value restriction (polymorphic fields) works!"
