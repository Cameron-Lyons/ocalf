type 'a stream = Cons of 'a * 'a stream Lazy.t

let hd (Cons (x, _)) = x

let tl (Cons (_, rest)) = Lazy.force rest

let rec take n s =
  if n = 0 then []
  else hd s :: take (n - 1) (tl s)

let rec nats_from n = Cons (n, lazy (nats_from (n + 1)))

let rec map f (Cons (x, rest)) =
  Cons (f x, lazy (map f (Lazy.force rest)))

let rec filter p (Cons (x, rest)) =
  if p x then Cons (x, lazy (filter p (Lazy.force rest)))
  else filter p (Lazy.force rest)

let () =
  let nats = nats_from 1 in
  assert (take 5 nats = [1; 2; 3; 4; 5]);

  let evens = filter (fun x -> x mod 2 = 0) nats in
  assert (take 5 evens = [2; 4; 6; 8; 10]);

  let squares = map (fun x -> x * x) nats in
  assert (take 5 squares = [1; 4; 9; 16; 25]);

  print_endline "Lazy streams work!"
