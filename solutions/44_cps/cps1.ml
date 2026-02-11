let add_cps x y k =
  k (x + y)

let mul_cps x y k =
  k (x * y)

let square_cps x k =
  mul_cps x x k

let pythagoras_cps x y k =
  square_cps x (fun x2 ->
    square_cps y (fun y2 ->
      add_cps x2 y2 k))

let rec fold_cps f acc lst k =
  match lst with
  | [] -> k acc
  | hd :: tl -> f acc hd (fun acc' -> fold_cps f acc' tl k)

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
