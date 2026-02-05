let success = Ok 42
let failure = Error "something went wrong"

let () =
  assert (success = Ok 42);
  assert (failure = Error "something went wrong");
  print_endline "Result values work!"
