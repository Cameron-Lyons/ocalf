let () =
  let s1 = Format.asprintf "Hello, %s!" "world" in
  assert (s1 = "Hello, world!");

  let s2 = Format.asprintf "%d + %d = %d" 2 3 5 in
  assert (s2 = "2 + 3 = 5");

  let format_list lst =
    Format.asprintf "[%a]"
      (Format.pp_print_list
        ~pp_sep:(fun fmt () -> Format.pp_print_string fmt "; ")
        Format.pp_print_int)
      lst
  in
  assert (format_list [1; 2; 3] = "[1; 2; 3]");
  assert (format_list [] = "[]");

  print_endline "Format module works!"
