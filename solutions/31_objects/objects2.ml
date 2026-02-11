class counter init = object
  val mutable count = init
  method get = count
  method incr = count <- count + 1
  method reset = count <- 0
end

class step_counter init step = object
  inherit counter init
  method! incr = count <- count + step
end

let () =
  let c = new counter 0 in
  assert (c#get = 0);
  c#incr;
  c#incr;
  c#incr;
  assert (c#get = 3);
  c#reset;
  assert (c#get = 0);

  let sc = new step_counter 0 5 in
  sc#incr;
  sc#incr;
  assert (sc#get = 10);

  print_endline "Classes work!"
