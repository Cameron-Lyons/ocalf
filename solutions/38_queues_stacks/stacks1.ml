let () =
  let s = Stack.create () in

  Stack.push 10 s;
  Stack.push 20 s;
  Stack.push 30 s;

  assert (Stack.length s = 3);

  let top = Stack.top s in
  assert (top = 30);

  let popped = Stack.pop s in
  assert (popped = 30);

  let popped2 = Stack.pop s in
  assert (popped2 = 20);
  assert (Stack.length s = 1);

  let items = ref [] in
  Stack.iter (fun x -> items := x :: !items) s;
  assert (!items = [10]);

  print_endline "Stack works!"
