(* TODO: Handle a custom Choose effect by selecting an element and resuming *)

open Effect
open Effect.Deep

type _ Effect.t += Choose : int list -> int Effect.t

let choose xs =
  ???

let with_choice (strategy : int list -> int) thunk =
  match thunk () with
  | value -> value
  | effect (Choose xs), k ->
      let picked = strategy xs in
      ???

let best_of_three a b c =
  let x = choose [ a; b; c ] in
  x + 1

let () =
  let max_choice xs = List.fold_left max min_int xs in
  let min_choice xs = List.fold_left min max_int xs in
  let r1 = with_choice max_choice (fun () -> best_of_three 3 9 5) in
  let r2 = with_choice min_choice (fun () -> best_of_three 3 9 5) in
  assert (r1 = 10);
  assert (r2 = 4);
  print_endline "Choice effect handler works!"
