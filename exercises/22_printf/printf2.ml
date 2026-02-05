(* TODO: Use advanced Printf formatting *)

let () =
  let n = 42 in
  let pi = 3.14159 in

  let s1 = ???  (* Pad n to 5 digits with leading zeros: "00042" *)
  in
  assert (s1 = "00042");

  let s2 = ???  (* Format pi with 2 decimal places: "3.14" *)
  in
  assert (s2 = "3.14");

  let s3 = ???  (* Right-align n in 10 characters: "        42" *)
  in
  assert (s3 = "        42");

  let s4 = ???  (* Left-align "hi" in 5 characters: "hi   " *)
  in
  assert (s4 = "hi   ");

  let s5 = ???  (* Hex format of 255: "ff" *)
  in
  assert (s5 = "ff");

  print_endline "Advanced Printf works!"
