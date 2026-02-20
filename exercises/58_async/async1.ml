(* TODO [Easy]: Chain callback-style operations while propagating errors *)

type 'a cb = ('a, string) result -> unit

let fetch_user id (k : string cb) =
  if id > 0 then k (Ok ("user-" ^ string_of_int id))
  else k (Error "invalid id")

let fetch_points user (k : int cb) =
  k (Ok (String.length user * 10))

let fetch_profile id (k : (string * int) cb) =
  ???
  (* Call fetch_user, then fetch_points for that user, and return (user, points).
     If any step fails, forward the Error unchanged. *)

let capture run =
  let cell = ref None in
  run (fun r -> cell := Some r);
  match !cell with
  | Some r -> r
  | None -> Error "callback was not invoked"

let () =
  assert (capture (fetch_profile 3) = Ok ("user-3", 60));
  assert (capture (fetch_profile 0) = Error "invalid id");
  print_endline "Async scaffold 1 works!"
