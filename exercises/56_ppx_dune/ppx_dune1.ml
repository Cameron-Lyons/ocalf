(* TODO [Easy]: Write manual show functions similar to deriving output *)

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
  | Published n -> ???  (* Format as "Published(<n>)" *)

let show_article a =
  ???
  (* Format exactly:
     { title = "..."; tags = ["..."; "..."]; status = ... } *)

let () =
  let a = { title = "OCaml"; tags = [ "fp"; "types" ]; status = Published 3 } in
  assert (show_status Draft = "Draft");
  assert (show_status (Published 3) = "Published(3)");
  assert (
    show_article a
    = "{ title = \"OCaml\"; tags = [\"fp\"; \"types\"]; status = Published(3) }");
  print_endline "PPX scaffold 1 works!"
