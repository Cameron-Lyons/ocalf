(* TODO: Use the Format module for string formatting *)

let () =
  let s1 = ???  (* Use Format.asprintf to format "Hello, %s!" with "world" *)
  in
  assert (s1 = "Hello, world!");

  let s2 = ???  (* Use Format.asprintf to format "%d + %d = %d" with 2, 3, 5 *)
  in
  assert (s2 = "2 + 3 = 5");

  let format_list lst =
    ???
    (* Use Format.asprintf with Format.pp_print_list to format a list of ints.
       Separator should be "; " using Format.pp_print_string.
       Format string: "[%a]" with the list printer.
       Use Format.pp_print_int for each element. *)
  in
  assert (format_list [1; 2; 3] = "[1; 2; 3]");
  assert (format_list [] = "[]");

  print_endline "Format module works!"
