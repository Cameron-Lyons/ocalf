module StringMap = Map.Make(String)

let scores =
  StringMap.(empty |> add "alice" 95 |> add "bob" 87 |> add "carol" 92)

let format_score name =
  try
    let open Printf in
    sprintf "%s: %d" name (StringMap.find name scores)
  with Not_found -> "unknown"

let total =
  StringMap.(fold (fun _ v acc -> acc + v) scores 0)

let () =
  assert (StringMap.find "alice" scores = 95);
  assert (StringMap.cardinal scores = 3);
  assert (format_score "alice" = "alice: 95");
  assert (format_score "dave" = "unknown");
  assert (total = 274);
  print_endline "Local opens work!"
