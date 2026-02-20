(* TODO [Medium]: Mark this sink as contravariant and implement contra_map *)

type 'a sink = ???  (* Should expose consume : 'a -> string *)

let contra_map f s =
  ???  (* Build a sink for new input type by pre-processing with f *)

let parse_pet = function
  | "dog" -> `Dog
  | "cat" -> `Cat
  | _ -> `Dog

let () =
  let animal_sink : [ `Dog | `Cat ] sink =
    {
      consume = (function
        | `Dog -> "DOG"
        | `Cat -> "CAT");
    }
  in
  let string_sink = contra_map parse_pet animal_sink in
  assert (string_sink.consume "dog" = "DOG");
  assert (string_sink.consume "cat" = "CAT");
  print_endline "Variance (contravariance) works!"
