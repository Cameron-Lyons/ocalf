(* TODO: Use extensible variants for a plugin system *)

type _ command = ..

type _ command += Get : string -> string option command
type _ command += Set : string * string -> unit command

type handler = { handle : 'a. 'a command -> 'a option }

let memory_store () : handler =
  let tbl = Hashtbl.create 16 in
  { handle = fun (type a) (cmd : a command) : a option ->
    ???
    (* Match on cmd:
       - Get key -> Some (Hashtbl.find_opt tbl key)
       - Set (key, value) -> Hashtbl.replace tbl key value; Some ()
       - _ -> None *)
  }

let run (h : handler) (cmd : 'a command) : 'a =
  match h.handle cmd with
  | Some result -> ???  (* Return the result *)
  | None -> ???  (* Raise Failure "unhandled command" *)

let () =
  let store = memory_store () in
  run store (Set ("name", "Alice"));
  run store (Set ("age", "30"));
  assert (run store (Get "name") = Some "Alice");
  assert (run store (Get "missing") = None);
  assert (run store (Get "age") = Some "30");

  print_endline "Extensible variant plugins work!"
