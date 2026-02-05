let describe_point point =
  match point with
  | (0, 0) -> "origin"
  | (_, 0) -> "on x-axis"
  | (0, _) -> "on y-axis"
  | (_, _) -> "in quadrant"

let () =
  assert (describe_point (0, 0) = "origin");
  assert (describe_point (5, 0) = "on x-axis");
  assert (describe_point (0, 3) = "on y-axis");
  assert (describe_point (2, 4) = "in quadrant");
  print_endline "Pattern matching on tuples works!"
