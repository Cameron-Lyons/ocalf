let join_with_sep sep parts =
  let b = Buffer.create 128 in
  let rec loop = function
    | [] -> ()
    | [ x ] -> Buffer.add_string b x
    | x :: xs ->
        Buffer.add_string b x;
        Buffer.add_string b sep;
        loop xs
  in
  loop parts;
  Buffer.contents b

let () =
  assert (join_with_sep "," [ "a"; "b"; "c" ] = "a,b,c");
  assert (join_with_sep "::" [ "x"; "y" ] = "x::y");

  let parts = List.init 5000 (fun _ -> "x") in
  let joined = join_with_sep "," parts in
  assert (String.length joined = 9999);
  print_endline "Performance scaffold 2 works!"
