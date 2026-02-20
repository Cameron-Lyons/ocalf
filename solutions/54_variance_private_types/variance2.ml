type -'a sink = { consume : 'a -> string }

let contra_map f s =
  { consume = (fun x -> s.consume (f x)) }

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
