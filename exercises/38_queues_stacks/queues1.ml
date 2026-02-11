(* TODO: Use the Queue module *)

let () =
  let q = ???  (* Create an empty queue using Queue.create *)
  in

  ???;  (* Push 10 onto the queue using Queue.push *)
  ???;  (* Push 20 *)
  ???;  (* Push 30 *)

  assert (Queue.length q = 3);

  let first = ???  (* Peek at the front element using Queue.peek *)
  in
  assert (first = 10);

  let popped = ???  (* Pop from the queue using Queue.pop *)
  in
  assert (popped = 10);
  assert (Queue.length q = 2);

  let popped2 = ???  (* Pop again *)
  in
  assert (popped2 = 20);

  let items = ref [] in
  ???;  (* Use Queue.iter to collect remaining items into the list *)
  assert (!items = [30]);

  assert (Queue.is_empty q = false);
  ignore (Queue.pop q);
  assert (Queue.is_empty q = true);

  print_endline "Queue works!"
