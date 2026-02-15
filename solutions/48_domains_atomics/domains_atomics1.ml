let increment_many counter n =
  for _ = 1 to n do
    Atomic.incr counter
  done

let run_counter n_per_domain =
  let counter = Atomic.make 0 in
  let d1 = Domain.spawn (fun () -> increment_many counter n_per_domain) in
  let d2 = Domain.spawn (fun () -> increment_many counter n_per_domain) in
  Domain.join d1;
  Domain.join d2;
  Atomic.get counter

let () =
  let total = run_counter 50_000 in
  assert (total = 100_000);
  print_endline "Domains + Atomics work!"
