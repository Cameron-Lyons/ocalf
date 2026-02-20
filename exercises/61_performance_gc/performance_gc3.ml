(* TODO [Hard]: Capture basic runtime + GC allocation metrics for a computation *)

type metrics =
  {
    cpu_seconds : float;
    minor_words : float;
    promoted_words : float;
  }

let profile f =
  ???
  (* Use Sys.time and Gc.quick_stat before/after running f (). *)

let () =
  let m = profile (fun () -> ignore (List.init 20_000 (fun i -> i * i))) in
  assert (m.cpu_seconds >= 0.0);
  assert (m.minor_words >= 0.0);
  assert (m.promoted_words >= 0.0);
  print_endline "Performance scaffold 3 works!"
