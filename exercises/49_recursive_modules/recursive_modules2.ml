(* TODO: Use recursive modules to define mutually recursive tree types and size functions *)

module rec Node : sig
  type t = { value : int; children : Forest.t }
  val size : t -> int
end = struct
  type t = { value : int; children : Forest.t }

  let size n =
    1 + ???
end
and Forest : sig
  type t = Empty | Cons of Node.t * t
  val size : t -> int
end = struct
  type t = Empty | Cons of Node.t * t

  let rec size = function
    | Empty -> 0
    | Cons (node, rest) -> ???
end

let sample =
  Node.{
    value = 1;
    children =
      Forest.Cons
        ({ value = 2; children = Forest.Empty },
         Forest.Cons ({ value = 3; children = Forest.Empty }, Forest.Empty));
  }

let () =
  assert (Node.size sample = 3);
  print_endline "Recursive modules (types + functions) work!"
