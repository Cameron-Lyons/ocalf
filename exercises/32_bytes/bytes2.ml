(* TODO: Use Bytes module functions *)

let () =
  let src = Bytes.of_string "Hello, world!" in

  let dest = Bytes.create 5 in
  ???;  (* Use Bytes.blit to copy 5 bytes from src starting at index 7 into dest at index 0 *)
  assert (Bytes.to_string dest = "world");

  let sub = ???  (* Use Bytes.sub_string to extract bytes 0-4 from src as a string *)
  in
  assert (sub = "Hello");

  let cat = ???  (* Use Bytes.cat to concatenate (Bytes.of_string "foo") and (Bytes.of_string "bar") *)
  in
  assert (Bytes.to_string cat = "foobar");

  let init = ???  (* Use Bytes.init to create 5 bytes where byte i is Char.chr (65 + i), i.e. "ABCDE" *)
  in
  assert (Bytes.to_string init = "ABCDE");

  print_endline "Bytes operations work!"
