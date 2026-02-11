let () =
  let buf = Buffer.create 16 in

  Buffer.add_string buf "Hello";
  Buffer.add_string buf ", ";
  Buffer.add_string buf "world";
  Buffer.add_char buf '!';

  let result = Buffer.contents buf in
  assert (result = "Hello, world!");

  Buffer.clear buf;

  for i = 1 to 5 do
    if i > 1 then Buffer.add_string buf "-";
    Buffer.add_string buf (string_of_int i)
  done;

  let nums = Buffer.contents buf in
  assert (nums = "1-2-3-4-5");

  print_endline "Buffer works!"
