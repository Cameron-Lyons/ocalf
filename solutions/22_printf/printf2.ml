let () =
  let n = 42 in
  let pi = 3.14159 in

  let s1 = Printf.sprintf "%05d" n in
  assert (s1 = "00042");

  let s2 = Printf.sprintf "%.2f" pi in
  assert (s2 = "3.14");

  let s3 = Printf.sprintf "%10d" n in
  assert (s3 = "        42");

  let s4 = Printf.sprintf "%-5s" "hi" in
  assert (s4 = "hi   ");

  let s5 = Printf.sprintf "%x" 255 in
  assert (s5 = "ff");

  print_endline "Advanced Printf works!"
