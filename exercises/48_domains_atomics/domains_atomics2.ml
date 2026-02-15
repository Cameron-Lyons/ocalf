(* TODO: Implement atomic max update with compare-and-set across domains *)

let rec update_max cell x =
  let current = Atomic.get cell in
  if x <= current then ()
  else if Atomic.compare_and_set cell current x then ()
  else ???  (* Retry if another domain raced us *)

let update_many cell xs =
  List.iter (fun x -> update_max cell x) xs

let parallel_max lists =
  let cell = Atomic.make min_int in
  let domains =
    List.map (fun xs -> Domain.spawn (fun () -> update_many cell xs)) lists
  in
  List.iter Domain.join domains;
  Atomic.get cell

let () =
  let m = parallel_max [ [ 4; 9; 2 ]; [ 5; 100; 8 ]; [ 7; 3; 42 ] ] in
  assert (m = 100);
  print_endline "Atomic max update works!"
