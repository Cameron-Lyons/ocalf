let () =
  let q = Queue.create () in

  Queue.push 10 q;
  Queue.push 20 q;
  Queue.push 30 q;

  assert (Queue.length q = 3);

  let first = Queue.peek q in
  assert (first = 10);

  let popped = Queue.pop q in
  assert (popped = 10);
  assert (Queue.length q = 2);

  let popped2 = Queue.pop q in
  assert (popped2 = 20);

  let items = ref [] in
  Queue.iter (fun x -> items := x :: !items) q;
  assert (!items = [30]);

  assert (Queue.is_empty q = false);
  ignore (Queue.pop q);
  assert (Queue.is_empty q = true);

  print_endline "Queue works!"
