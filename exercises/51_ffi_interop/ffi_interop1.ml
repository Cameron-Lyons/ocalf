(* TODO: Encode/decode a fixed binary header (like a C struct) using bytes *)

let encode_header ~version ~length =
  let b = Bytes.create 3 in
  if version < 0 || version > 255 then invalid_arg "version out of range";
  if length < 0 || length > 65_535 then invalid_arg "length out of range";
  Bytes.set b 0 (Char.chr version);
  Bytes.set b 1 (Char.chr ???);  (* High byte of length *)
  Bytes.set b 2 (Char.chr ???);  (* Low byte of length *)
  b

let decode_header b =
  if Bytes.length b <> 3 then invalid_arg "expected 3 bytes";
  let version = Char.code (Bytes.get b 0) in
  let hi = Char.code (Bytes.get b 1) in
  let lo = Char.code (Bytes.get b 2) in
  let length = ??? in
  (version, length)

let () =
  let encoded = encode_header ~version:7 ~length:513 in
  let (version, length) = decode_header encoded in
  assert (version = 7);
  assert (length = 513);
  print_endline "Binary interop encoding works!"
