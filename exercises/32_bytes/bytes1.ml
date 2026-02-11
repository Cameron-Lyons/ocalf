(* TODO: Create and manipulate byte sequences *)

let () =
  let b = ???  (* Create a Bytes of length 5 filled with 'x' using Bytes.make *)
  in
  assert (Bytes.length b = 5);
  assert (Bytes.get b 0 = 'x');

  ???;  (* Set byte at index 0 to 'H' using Bytes.set *)
  ???;  (* Set byte at index 1 to 'i' *)

  let s = ???  (* Convert the Bytes to a string using Bytes.to_string *)
  in
  assert (String.sub s 0 2 = "Hi");

  let from_str = ???  (* Convert "hello" to Bytes using Bytes.of_string *)
  in
  ???;  (* Set index 0 to 'H' *)
  assert (Bytes.to_string from_str = "Hello");

  print_endline "Bytes basics work!"
