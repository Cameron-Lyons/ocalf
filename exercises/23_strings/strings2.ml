(* TODO: Use Buffer for efficient string building *)

let () =
  let buf = Buffer.create 16 in

  ???;  (* Add the string "Hello" to the buffer *)
  ???;  (* Add a comma and space ", " to the buffer *)
  ???;  (* Add the string "world" to the buffer *)
  ???;  (* Add the character '!' to the buffer *)

  let result = ???  (* Get the buffer contents as a string *)
  in
  assert (result = "Hello, world!");

  ???;  (* Clear the buffer *)

  for i = 1 to 5 do
    ???  (* Add string_of_int i to the buffer, separated by "-" for i > 1 *)
  done;

  let nums = ???  (* Get the buffer contents *)
  in
  assert (nums = "1-2-3-4-5");

  print_endline "Buffer works!"
