(* TODO: Implement memoization with closures *)

let memoize f =
  let cache = Hashtbl.create 16 in
  fun x ->
    ???
    (* Check if x is in cache. If so, return cached value.
       Otherwise, compute f x, store it in cache, and return it. *)

let call_count = ref 0

let slow_square n =
  incr call_count;
  n * n

let memo_rec f =
  let cache = Hashtbl.create 16 in
  let rec memoized x =
    match Hashtbl.find_opt cache x with
    | Some v -> v
    | None ->
      let v = ???  (* Call f with memoized as the recursive argument and x *)
      in
      Hashtbl.add cache x v;
      v
  in
  memoized

let fibonacci = memo_rec (fun fib n ->
  ???)  (* if n <= 1 then n else fib (n-1) + fib (n-2) *)

let () =
  let memo_square = memoize slow_square in
  call_count := 0;
  assert (memo_square 5 = 25);
  assert (memo_square 5 = 25);
  assert (memo_square 5 = 25);
  assert (!call_count = 1);

  assert (memo_square 3 = 9);
  assert (!call_count = 2);

  assert (fibonacci 10 = 55);
  assert (fibonacci 30 = 832040);
  assert (fibonacci 0 = 0);
  assert (fibonacci 1 = 1);

  print_endline "Memoization works!"
