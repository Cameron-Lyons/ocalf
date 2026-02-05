let describe_status status =
  match status with
  | `Ok -> "success"
  | `Error msg -> "error: " ^ msg
  | `Pending -> "pending"

let () =
  let s1 = `Ok in
  let s2 = `Error "not found" in
  let s3 = `Pending in

  assert (describe_status s1 = "success");
  assert (describe_status s2 = "error: not found");
  assert (describe_status s3 = "pending");
  print_endline "Polymorphic variants work!"
