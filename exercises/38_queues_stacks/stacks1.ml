(* TODO: Use the Stack module *)

let () =
  let s = ???  (* Create an empty stack using Stack.create *)
  in

  ???;  (* Push 10 onto the stack using Stack.push *)
  ???;  (* Push 20 *)
  ???;  (* Push 30 *)

  assert (Stack.length s = 3);

  let top = ???  (* Peek at the top element using Stack.top *)
  in
  assert (top = 30);

  let popped = ???  (* Pop from the stack using Stack.pop *)
  in
  assert (popped = 30);

  let popped2 = ???  (* Pop again *)
  in
  assert (popped2 = 20);
  assert (Stack.length s = 1);

  let items = ref [] in
  ???;  (* Use Stack.iter to collect remaining items into the list *)
  assert (!items = [10]);

  print_endline "Stack works!"
