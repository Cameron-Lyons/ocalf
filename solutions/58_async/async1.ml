type 'a cb = ('a, string) result -> unit

let fetch_user id (k : string cb) =
  if id > 0 then k (Ok ("user-" ^ string_of_int id))
  else k (Error "invalid id")

let fetch_points user (k : int cb) =
  k (Ok (String.length user * 10))

let fetch_profile id (k : (string * int) cb) =
  fetch_user id (function
    | Error e -> k (Error e)
    | Ok user ->
        fetch_points user (function
          | Error e -> k (Error e)
          | Ok points -> k (Ok (user, points))))

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
