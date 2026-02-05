(* TODO: Use polymorphic variants *)

let describe_status status =
  match status with
  | `Ok -> "success"
  | `Error msg -> "error: " ^ msg
  | `Pending -> "pending"

let () =
  let s1 = ??? in (* Create `Ok *)
  let s2 = ??? in (* Create `Error with message "not found" *)
  let s3 = ??? in (* Create `Pending *)

  assert (describe_status s1 = "success");
  assert (describe_status s2 = "error: not found");
  assert (describe_status s3 = "pending");
  print_endline "Polymorphic variants work!"
