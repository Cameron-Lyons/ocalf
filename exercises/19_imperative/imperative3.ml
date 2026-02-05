(* TODO: Use the sequence operator ; *)

let side_effect_counter = ref 0

let do_something () =
  side_effect_counter := !side_effect_counter + 1;
  42

let () =
  (* Call do_something three times, ignoring return values, then get result *)
  let result =
    ??? (* Use ; to sequence: do_something (); do_something (); do_something () *)
  in

  assert (!side_effect_counter = 3);
  assert (result = 42);

  (* Use begin...end to group sequential operations *)
  let value =
    if true then begin
      side_effect_counter := 0;
      ??? (* Set side_effect_counter to 100 and return "done" *)
    end
    else
      "not done"
  in

  assert (!side_effect_counter = 100);
  assert (value = "done");

  print_endline "Sequences work!"
