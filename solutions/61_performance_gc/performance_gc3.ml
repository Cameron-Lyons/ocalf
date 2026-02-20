type metrics =
  {
    cpu_seconds : float;
    minor_words : float;
    promoted_words : float;
  }

let profile f =
  Gc.full_major ();
  let t0 = Sys.time () in
  let g0 = Gc.quick_stat () in
  f ();
  let g1 = Gc.quick_stat () in
  let t1 = Sys.time () in
  {
    cpu_seconds = t1 -. t0;
    minor_words = g1.minor_words -. g0.minor_words;
    promoted_words = g1.promoted_words -. g0.promoted_words;
  }

let () =
  let m = profile (fun () -> ignore (List.init 20_000 (fun i -> i * i))) in
  assert (m.cpu_seconds >= 0.0);
  assert (m.minor_words >= 0.0);
  assert (m.promoted_words >= 0.0);
  print_endline "Performance scaffold 3 works!"
