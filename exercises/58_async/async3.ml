(* TODO [Hard]: Add cancellation-aware bind for token-threaded tasks *)

type cancel_token = { mutable cancelled : bool }

type 'a task = cancel_token -> ('a, string) result

let return x _ = Ok x
let fail msg _ = Error msg

let bind t f token =
  ???
  (* If token.cancelled then Error "cancelled".
     Otherwise run t token; if Ok x then run (f x) token; if Error e propagate e. *)

let ( let* ) = bind

let check_point token =
  if token.cancelled then Error "cancelled" else Ok ()

let step x token =
  match check_point token with
  | Error e -> Error e
  | Ok () -> Ok (x + 1)

let () =
  let token1 = { cancelled = false } in
  let program =
    let* a = step 1 in
    let* b = step a in
    return b
  in
  assert (program token1 = Ok 3);

  let token2 = { cancelled = true } in
  assert (program token2 = Error "cancelled");
  print_endline "Async scaffold 3 works!"
