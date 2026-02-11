(* TODO: Use closures to build iterators and generators *)

let range_iter ~from ~until =
  let current = ref from in
  fun () ->
    ???
    (* If !current < until, return Some of the current value and advance it.
       Otherwise return None. *)

let fibonacci_gen () =
  let a = ref 0 in
  let b = ref 1 in
  fun () ->
    ???
    (* Save the current value of !a, update a and b to the next pair,
       and return the saved value. *)

let take n gen =
  let rec aux acc i =
    if i >= n then List.rev acc
    else
      ???  (* Call gen (), match the result: Some v -> recurse, None -> return List.rev acc *)
  in
  aux [] 0

let () =
  let iter = range_iter ~from:1 ~until:4 in
  assert (iter () = Some 1);
  assert (iter () = Some 2);
  assert (iter () = Some 3);
  assert (iter () = None);
  assert (iter () = None);

  let fib = fibonacci_gen () in
  let first_8 = List.init 8 (fun _ -> fib ()) in
  assert (first_8 = [0; 1; 1; 2; 3; 5; 8; 13]);

  let iter2 = range_iter ~from:10 ~until:15 in
  let taken = take 3 (fun () -> iter2 ()) in
  assert (taken = [10; 11; 12]);

  print_endline "Closure iterators work!"
