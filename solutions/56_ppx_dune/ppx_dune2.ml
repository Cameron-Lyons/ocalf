type test =
  {
    name : string;
    run : unit -> bool;
  }

let make_test name run = { name; run }

let run_suite tests =
  List.fold_left
    (fun failures t ->
      if t.run () then failures else failures @ [ t.name ])
    [] tests

let () =
  let tests =
    [
      make_test "math" (fun () -> 2 + 2 = 4);
      make_test "string" (fun () -> String.uppercase_ascii "ocaml" = "OCAML");
      make_test "intentional-fail" (fun () -> 1 + 1 = 3);
    ]
  in
  assert (run_suite tests = [ "intentional-fail" ]);
  print_endline "PPX scaffold 2 works!"
