type library =
  {
    name : string;
    public_name : string option;
    pps : string list;
    inline_tests : bool;
  }

let contains_sub hay needle =
  let re = Str.regexp_string needle in
  try
    ignore (Str.search_forward re hay 0);
    true
  with Not_found -> false

let dune_stanza lib =
  let fields = ref [ Printf.sprintf "(name %s)" lib.name ] in
  (match lib.public_name with
  | None -> ()
  | Some p -> fields := !fields @ [ Printf.sprintf "(public_name %s)" p ]);
  if lib.pps <> [] then
    fields :=
      !fields
      @
      [
        Printf.sprintf "(preprocess (pps %s))" (String.concat " " lib.pps);
      ];
  if lib.inline_tests then fields := !fields @ [ "(inline_tests)" ];
  Printf.sprintf "(library %s)" (String.concat " " !fields)

let () =
  let stanza =
    dune_stanza
      {
        name = "demo";
        public_name = Some "ocalf-demo";
        pps = [ "ppx_deriving.show"; "ppx_inline_test" ];
        inline_tests = true;
      }
  in
  assert (contains_sub stanza "(library");
  assert (contains_sub stanza "(name demo)");
  assert (contains_sub stanza "(public_name ocalf-demo)");
  assert (contains_sub stanza "(preprocess (pps ppx_deriving.show ppx_inline_test))");
  assert (contains_sub stanza "(inline_tests)");
  print_endline "PPX scaffold 3 works!"
