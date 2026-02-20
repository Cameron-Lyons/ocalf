(* TODO [Hard]: Decode a tiny binary packet and validate payload checksum *)

type packet =
  {
    tag : int;
    payload : string;
  }

let checksum s =
  let rec loop acc i =
    if i >= String.length s then acc land 0xFF
    else loop (acc + Char.code s.[i]) (i + 1)
  in
  loop 0 0

let encode_packet p =
  let len = String.length p.payload in
  let b = Bytes.create (2 + 2 + len + 1) in
  Bytes.set b 0 (Char.chr ((p.tag lsr 8) land 0xFF));
  Bytes.set b 1 (Char.chr (p.tag land 0xFF));
  Bytes.set b 2 (Char.chr ((len lsr 8) land 0xFF));
  Bytes.set b 3 (Char.chr (len land 0xFF));
  Bytes.blit_string p.payload 0 b 4 len;
  Bytes.set b (4 + len) (Char.chr (checksum p.payload));
  b

let decode_packet b =
  ???
  (* Parse {tag; payload}; verify length and checksum.
     Return Error "invalid length" or Error "checksum mismatch" as needed. *)

let () =
  let p = { tag = 0x1001; payload = "abc" } in
  (match decode_packet (encode_packet p) with
  | Ok p' -> assert (p' = p)
  | Error _ -> assert false);

  let bad = Bytes.copy (encode_packet p) in
  let i = Bytes.length bad - 1 in
  let last = Char.code (Bytes.get bad i) in
  Bytes.set bad i (Char.chr ((last + 1) land 0xFF));
  assert (decode_packet bad = Error "checksum mismatch");
  print_endline "FFI scaffold 3 works!"
