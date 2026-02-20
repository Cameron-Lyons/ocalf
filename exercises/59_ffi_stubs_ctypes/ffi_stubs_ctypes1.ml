(* TODO [Easy]: Decode a 32-bit little-endian unsigned integer from bytes *)

let encode_u32_le n =
  let b = Bytes.create 4 in
  Bytes.set b 0 (Char.chr (n land 0xFF));
  Bytes.set b 1 (Char.chr ((n lsr 8) land 0xFF));
  Bytes.set b 2 (Char.chr ((n lsr 16) land 0xFF));
  Bytes.set b 3 (Char.chr ((n lsr 24) land 0xFF));
  b

let decode_u32_le b =
  ???
  (* Reconstruct with Char.code + shifts from 4 bytes (little-endian). *)

let () =
  let n = 0x12AB34CD in
  let b = encode_u32_le n in
  assert (Bytes.length b = 4);
  assert (decode_u32_le b = n);
  print_endline "FFI scaffold 1 works!"
