(* TODO [Medium]: Build a tiny inline-test runner (let%test style, but manual) *)

type test =
  {
    name : string;
    run : unit -> bool;
  }

let make_test name run = { name; run }

let run_suite tests =
  ???  (* Return names of failing tests in input order *)

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
