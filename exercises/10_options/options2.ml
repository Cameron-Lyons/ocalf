(* TODO: Pattern match on options *)

let get_or_default opt default =
  match opt with
  | ??? -> ???
  | ??? -> ???

let () =
  assert (get_or_default (Some 5) 0 = 5);
  assert (get_or_default None 0 = 0);
  assert (get_or_default (Some "hello") "default" = "hello");
  assert (get_or_default None "default" = "default");
  print_endline "Option pattern matching works!"
