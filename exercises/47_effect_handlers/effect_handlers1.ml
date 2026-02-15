(* TODO: Use an effect handler to provide values for Read_env *)

open Effect
open Effect.Deep

type _ Effect.t += Read_env : string -> string option Effect.t

let read_env key =
  ???  (* Perform the Read_env effect for key *)

let with_env env thunk =
  match thunk () with
  | value -> value
  | effect (Read_env key), k ->
      let value = List.assoc_opt key env in
      ???  (* Resume the continuation with the looked-up value *)

let port_of_string = function
  | Some s -> int_of_string s
  | None -> 8080

let current_port () =
  read_env "PORT" |> port_of_string

let () =
  let p1 = with_env [ ("PORT", "9000") ] current_port in
  let p2 = with_env [] current_port in
  assert (p1 = 9000);
  assert (p2 = 8080);
  print_endline "Effect handlers work!"
