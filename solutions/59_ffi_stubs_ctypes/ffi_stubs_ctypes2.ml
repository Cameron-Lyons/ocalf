let to_c_string s =
  let len = String.length s in
  let b = Bytes.create (len + 1) in
  Bytes.blit_string s 0 b 0 len;
  Bytes.set b len '\000';
  b

let of_c_string ~max_len b =
  let limit = min max_len (Bytes.length b) in
  let rec find_nul i =
    if i >= limit then None
    else if Bytes.get b i = '\000' then Some i
    else find_nul (i + 1)
  in
  match find_nul 0 with
  | None -> Error "missing NUL terminator"
  | Some len -> Ok (Bytes.sub_string b 0 len)

let () =
  let good = to_c_string "hello" in
  assert (of_c_string ~max_len:16 good = Ok "hello");

  let bad = Bytes.of_string "abc" in
  assert (of_c_string ~max_len:3 bad = Error "missing NUL terminator");
  print_endline "FFI scaffold 2 works!"
