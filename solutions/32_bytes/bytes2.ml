let () =
  let src = Bytes.of_string "Hello, world!" in

  let dest = Bytes.create 5 in
  Bytes.blit src 7 dest 0 5;
  assert (Bytes.to_string dest = "world");

  let sub = Bytes.sub_string src 0 5 in
  assert (sub = "Hello");

  let cat = Bytes.cat (Bytes.of_string "foo") (Bytes.of_string "bar") in
  assert (Bytes.to_string cat = "foobar");

  let init = Bytes.init 5 (fun i -> Char.chr (65 + i)) in
  assert (Bytes.to_string init = "ABCDE");

  print_endline "Bytes operations work!"
