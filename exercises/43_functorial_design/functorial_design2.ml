(* TODO: Design a functor that adds logging to any key-value store *)

module type KV_Store = sig
  type key
  type 'a t
  val create : unit -> 'a t
  val set : key -> 'a -> 'a t -> unit
  val get : key -> 'a t -> 'a option
end

module HashKV : KV_Store with type key = string = struct
  type key = string
  type 'a t = (string, 'a) Hashtbl.t
  let create () = Hashtbl.create 16
  let set k v t = Hashtbl.replace t k v
  let get k t = Hashtbl.find_opt t k
end

module WithLogging (S : KV_Store with type key = string) : sig
  include KV_Store with type key = string
  val get_log : 'a t -> string list
end = struct
  type key = string
  type 'a t = { store : 'a S.t; log : string list ref }

  let create () = ???  (* Create with an empty store and empty log *)

  let set k v t =
    ???
    (* Append "set:<key>" to the log, then delegate to S.set *)

  let get k t =
    ???
    (* Append "get:<key>" to the log, then delegate to S.get *)

  let get_log t = ???  (* Return the reversed log for chronological order *)
end

module LoggedKV = WithLogging(HashKV)

let () =
  let store = LoggedKV.create () in
  LoggedKV.set "name" "Alice" store;
  LoggedKV.set "age" "30" store;
  assert (LoggedKV.get "name" store = Some "Alice");
  assert (LoggedKV.get "missing" store = None);

  let log = LoggedKV.get_log store in
  assert (log = ["set:name"; "set:age"; "get:name"; "get:missing"]);

  print_endline "Functor composition works!"
