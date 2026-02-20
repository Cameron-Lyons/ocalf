type status =
  | Draft
  | Published of int

type article =
  {
    title : string;
    tags : string list;
    status : status;
  }

let show_status = function
  | Draft -> "Draft"
  | Published n -> Printf.sprintf "Published(%d)" n

let show_article a =
  let tags =
    a.tags
    |> List.map (fun t -> Printf.sprintf "\"%s\"" t)
    |> String.concat "; "
  in
  Printf.sprintf
    "{ title = \"%s\"; tags = [%s]; status = %s }"
    a.title tags (show_status a.status)

let () =
  let a = { title = "OCaml"; tags = [ "fp"; "types" ]; status = Published 3 } in
  assert (show_status Draft = "Draft");
  assert (show_status (Published 3) = "Published(3)");
  assert (
    show_article a
    = "{ title = \"OCaml\"; tags = [\"fp\"; \"types\"]; status = Published(3) }");
  print_endline "PPX scaffold 1 works!"
