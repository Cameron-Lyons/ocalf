(* TODO: Use local open to bring module contents into scope *)

module StringMap = Map.Make(String)

let scores =
  ???
  (* Use StringMap.( ... ) local open syntax to build a map:
     empty |> add "alice" 95 |> add "bob" 87 |> add "carol" 92 *)

let format_score name =
  ???
  (* Use let open Printf in ... to format: sprintf "%s: %d" name (find name scores)
     Wrap in try/with to return "unknown" for missing names *)

let total =
  ???
  (* Use StringMap.(fold (fun _ v acc -> acc + v) scores 0) with local open *)

let () =
  assert (StringMap.find "alice" scores = 95);
  assert (StringMap.cardinal scores = 3);
  assert (format_score "alice" = "alice: 95");
  assert (format_score "dave" = "unknown");
  assert (total = 274);
  print_endline "Local opens work!"
