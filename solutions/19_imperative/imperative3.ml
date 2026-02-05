let side_effect_counter = ref 0

let do_something () =
  side_effect_counter := !side_effect_counter + 1;
  42

let () =
  let result =
    do_something ();
    do_something ();
    do_something ()
  in

  assert (!side_effect_counter = 3);
  assert (result = 42);

  let value =
    if true then begin
      side_effect_counter := 0;
      side_effect_counter := 100;
      "done"
    end
    else
      "not done"
  in

  assert (!side_effect_counter = 100);
  assert (value = "done");

  print_endline "Sequences work!"
