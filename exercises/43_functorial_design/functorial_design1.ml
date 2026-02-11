(* TODO: Design a functor-based comparable collection *)

module type Comparable = sig
  type t
  val compare : t -> t -> int
end

module SortedList (C : Comparable) : sig
  type t
  val empty : t
  val insert : C.t -> t -> t
  val to_list : t -> C.t list
  val mem : C.t -> t -> bool
end = struct
  type t = C.t list

  let empty = ???  (* Empty list *)

  let rec insert x = function
    | [] -> ???  (* Singleton list *)
    | hd :: tl as lst ->
      let c = C.compare x hd in
      ???  (* If c = 0, return lst unchanged. If c < 0, prepend x. Otherwise, recurse. *)

  let to_list t = ???  (* Return the underlying list *)

  let rec mem x = function
    | [] -> ???
    | hd :: tl ->
      let c = C.compare x hd in
      ???  (* If c = 0, found. If c < 0, not in list. Otherwise recurse. *)
end

module IntSorted = SortedList(Int)
module StringSorted = SortedList(String)

let () =
  let s = IntSorted.(empty |> insert 3 |> insert 1 |> insert 4 |> insert 1 |> insert 5) in
  assert (IntSorted.to_list s = [1; 3; 4; 5]);
  assert (IntSorted.mem 3 s = true);
  assert (IntSorted.mem 2 s = false);

  let ss = StringSorted.(empty |> insert "banana" |> insert "apple" |> insert "cherry") in
  assert (StringSorted.to_list ss = ["apple"; "banana"; "cherry"]);

  print_endline "Functorial design works!"
