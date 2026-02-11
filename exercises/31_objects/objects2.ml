(* TODO: Define classes and create instances *)

class counter init = object
  val mutable count = init
  method get = ???  (* Return count *)
  method incr = ???  (* Increment count by 1 *)
  method reset = ???  (* Reset count to 0 *)
end

class step_counter init step = object
  inherit counter init
  method! incr = ???  (* Increment count by step instead of 1 *)
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
