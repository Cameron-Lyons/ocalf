(* TODO: Use phantom types for type-safe units *)

type meters
type seconds

type _ quantity = Qty : float -> _ quantity

let meters (v : float) : meters quantity = ???  (* Wrap v in a Qty *)
let seconds (v : float) : seconds quantity = ???  (* Wrap v in a Qty *)

let add_qty : type a. a quantity -> a quantity -> a quantity = fun (Qty a) (Qty b) ->
  ???  (* Return a Qty of a +. b *)

let get_value : type a. a quantity -> float = fun (Qty v) ->
  ???  (* Return the underlying float *)

let () =
  let d1 = meters 10.0 in
  let d2 = meters 20.0 in
  let d_total = add_qty d1 d2 in
  assert (get_value d_total = 30.0);

  let t1 = seconds 5.0 in
  let t2 = seconds 3.0 in
  let t_total = add_qty t1 t2 in
  assert (get_value t_total = 8.0);

  (* The following would not compile - type safety!
     let _ = add_qty d1 t1  (* Error: meters <> seconds *) *)

  print_endline "Phantom types work!"
