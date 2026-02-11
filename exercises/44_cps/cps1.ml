(* TODO: Convert functions to continuation-passing style *)

let add_cps x y k =
  ???  (* Call k with x + y *)

let mul_cps x y k =
  ???  (* Call k with x * y *)

let square_cps x k =
  ???  (* Use mul_cps to compute x * x, passing k as the continuation *)

let pythagoras_cps x y k =
  ???
  (* Use square_cps on x, then in that continuation use square_cps on y,
     then add the two results with add_cps, passing k *)

let rec fold_cps f acc lst k =
  match lst with
  | [] -> ???  (* Call k with acc *)
  | hd :: tl -> ???  (* Apply f acc hd in CPS, then recurse on tl *)

let () =
  add_cps 2 3 (fun r -> assert (r = 5));
  mul_cps 4 5 (fun r -> assert (r = 20));
  square_cps 6 (fun r -> assert (r = 36));

  pythagoras_cps 3 4 (fun r -> assert (r = 25));

  let sum_cps lst k = fold_cps (fun acc x k -> add_cps acc x k) 0 lst k in
  sum_cps [1; 2; 3; 4; 5] (fun r -> assert (r = 15));

  let big = List.init 1_000_000 (fun _ -> 1) in
  sum_cps big (fun r -> assert (r = 1_000_000));

  print_endline "CPS works!"
