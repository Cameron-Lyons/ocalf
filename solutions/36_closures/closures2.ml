let range_iter ~from ~until =
  let current = ref from in
  fun () ->
    if !current < until then begin
      let v = !current in
      incr current;
      Some v
    end else
      None

let fibonacci_gen () =
  let a = ref 0 in
  let b = ref 1 in
  fun () ->
    let v = !a in
    let next = !a + !b in
    a := !b;
    b := next;
    v

let take n gen =
  let rec aux acc i =
    if i >= n then List.rev acc
    else
      match gen () with
      | Some v -> aux (v :: acc) (i + 1)
      | None -> List.rev acc
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
