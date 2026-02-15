(* TODO: Convert between OCaml strings and null-terminated C-style byte strings *)

let to_c_string s =
  let len = String.length s in
  let b = Bytes.create (len + 1) in
  Bytes.blit_string s 0 b 0 len;
  Bytes.set b len ???;  (* Null terminator *)
  b

let from_c_string b =
  let rec find_nul i =
    if i >= Bytes.length b then invalid_arg "missing null terminator"
    else if Bytes.get b i = '\000' then i
    else find_nul (i + 1)
  in
  let n = find_nul 0 in
  Bytes.sub_string b 0 ???

let () =
  let b = to_c_string "hello" in
  assert (Bytes.length b = 6);
  assert (Bytes.get b 5 = '\000');
  assert (from_c_string b = "hello");
  print_endline "C-string conversion works!"
