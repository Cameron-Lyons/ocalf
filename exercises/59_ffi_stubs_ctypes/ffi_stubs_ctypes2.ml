(* TODO [Medium]: Decode C strings with a max scan length guard *)

let to_c_string s =
  let len = String.length s in
  let b = Bytes.create (len + 1) in
  Bytes.blit_string s 0 b 0 len;
  Bytes.set b len '\000';
  b

let of_c_string ~max_len b =
  ???
  (* Return Ok string up to first '\000' within max_len, else Error. *)

let () =
  let good = to_c_string "hello" in
  assert (of_c_string ~max_len:16 good = Ok "hello");

  let bad = Bytes.of_string "abc" in
  assert (of_c_string ~max_len:3 bad = Error "missing NUL terminator");
  print_endline "FFI scaffold 2 works!"
