(* TODO: Define and use custom exceptions *)

exception Negative_number of int
exception Too_large of int * int  (* value and max *)

let validate_age age =
  if age < 0 then ???  (* Raise Negative_number *)
  else if age > 150 then ???  (* Raise Too_large with age and 150 *)
  else age

let describe_age age =
  try
    let a = validate_age age in
    "Valid age: " ^ string_of_int a
  with
  | Negative_number n -> "Negative: " ^ string_of_int n
  | Too_large (n, max) -> "Too large: " ^ string_of_int n ^ " > " ^ string_of_int max

let () =
  assert (describe_age 25 = "Valid age: 25");
  assert (describe_age (-5) = "Negative: -5");
  assert (describe_age 200 = "Too large: 200 > 150");
  print_endline "Custom exceptions work!"
