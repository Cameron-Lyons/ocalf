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

  let create () = { store = S.create (); log = ref [] }

  let set k v t =
    t.log := ("set:" ^ k) :: !(t.log);
    S.set k v t.store

  let get k t =
    t.log := ("get:" ^ k) :: !(t.log);
    S.get k t.store

  let get_log t = List.rev !(t.log)
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
