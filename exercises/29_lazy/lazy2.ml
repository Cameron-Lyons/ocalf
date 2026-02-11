(* TODO: Use lazy for an infinite stream *)

type 'a stream = Cons of 'a * 'a stream Lazy.t

let hd (Cons (x, _)) = x

let tl (Cons (_, rest)) = ???  (* Force the rest of the stream *)

let rec take n s =
  if n = 0 then []
  else ???  (* Cons hd s onto the recursive take of (n-1) from the tail *)

let rec nats_from n = ???  (* Create an infinite stream: n, n+1, n+2, ... using Cons and lazy *)

let rec map f (Cons (x, rest)) =
  ???  (* Apply f to x and lazily map over the rest *)

let rec filter p (Cons (x, rest)) =
  if p x then ???  (* Keep x and lazily filter the rest *)
  else ???  (* Skip x and filter the forced rest *)

let () =
  let nats = nats_from 1 in
  assert (take 5 nats = [1; 2; 3; 4; 5]);

  let evens = filter (fun x -> x mod 2 = 0) nats in
  assert (take 5 evens = [2; 4; 6; 8; 10]);

  let squares = map (fun x -> x * x) nats in
  assert (take 5 squares = [1; 4; 9; 16; 25]);

  print_endline "Lazy streams work!"
