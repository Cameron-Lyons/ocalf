(* TODO [Medium]: Add a sharing constraint so A.t and B.t are the same type *)

module type S = sig
  type t
  val compare : t -> t -> int
  val show : t -> string
end

module Make_index (A : S) (B : ???) = struct
  module M = Map.Make (struct
    type t = A.t
    let compare = A.compare
  end)

  let insert_pair a b m =
    M.add a (A.show a ^ ":" ^ B.show b) m

  let find = M.find_opt
end

module IntA = struct
  type t = int
  let compare = Int.compare
  let show = string_of_int
end

module IntB = struct
  type t = int
  let compare = Int.compare
  let show x = "B" ^ string_of_int x
end

module I = Make_index (IntA) (IntB)

let () =
  let m = I.insert_pair 3 9 I.M.empty in
  assert (I.find 3 m = Some "3:B9");
  assert (I.find 4 m = None);
  print_endline "Advanced modules (sharing constraints) works!"
