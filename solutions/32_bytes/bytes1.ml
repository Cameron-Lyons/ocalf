let () =
  let b = Bytes.make 5 'x' in
  assert (Bytes.length b = 5);
  assert (Bytes.get b 0 = 'x');

  Bytes.set b 0 'H';
  Bytes.set b 1 'i';

  let s = Bytes.to_string b in
  assert (String.sub s 0 2 = "Hi");

  let from_str = Bytes.of_string "hello" in
  Bytes.set from_str 0 'H';
  assert (Bytes.to_string from_str = "Hello");

  print_endline "Bytes basics work!"
