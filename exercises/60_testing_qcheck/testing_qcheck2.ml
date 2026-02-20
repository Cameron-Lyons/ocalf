(* TODO [Medium]: Build a deterministic property checker over generated samples *)

type 'a prop_result =
  | Pass
  | Fail of
      {
        trial : int;
        value : 'a;
      }

let check_forall ~trials ~gen ~pred =
  ???
  (* Try inputs gen 0, gen 1, ... gen (trials-1).
     Return Pass if all satisfy pred, else Fail at first failing trial. *)

let () =
  let r1 = check_forall ~trials:20 ~gen:(fun i -> i) ~pred:(fun x -> x >= 0) in
  assert (r1 = Pass);

  let r2 = check_forall ~trials:20 ~gen:(fun i -> i - 5) ~pred:(fun x -> x >= 0) in
  assert (r2 = Fail { trial = 0; value = -5 });
  print_endline "Testing scaffold 2 works!"
