let encode_u32_le n =
  let b = Bytes.create 4 in
  Bytes.set b 0 (Char.chr (n land 0xFF));
  Bytes.set b 1 (Char.chr ((n lsr 8) land 0xFF));
  Bytes.set b 2 (Char.chr ((n lsr 16) land 0xFF));
  Bytes.set b 3 (Char.chr ((n lsr 24) land 0xFF));
  b

let decode_u32_le b =
  let b0 = Char.code (Bytes.get b 0) in
  let b1 = Char.code (Bytes.get b 1) in
  let b2 = Char.code (Bytes.get b 2) in
  let b3 = Char.code (Bytes.get b 3) in
  b0 lor (b1 lsl 8) lor (b2 lsl 16) lor (b3 lsl 24)

let () =
  let n = 0x12AB34CD in
  let b = encode_u32_le n in
  assert (Bytes.length b = 4);
  assert (decode_u32_le b = n);
  print_endline "FFI scaffold 1 works!"
