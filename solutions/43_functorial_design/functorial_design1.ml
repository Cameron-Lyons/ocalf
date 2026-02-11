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

  let empty = []

  let rec insert x = function
    | [] -> [x]
    | hd :: tl as lst ->
      let c = C.compare x hd in
      if c = 0 then lst
      else if c < 0 then x :: lst
      else hd :: insert x tl

  let to_list t = t

  let rec mem x = function
    | [] -> false
    | hd :: tl ->
      let c = C.compare x hd in
      if c = 0 then true
      else if c < 0 then false
      else mem x tl
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
