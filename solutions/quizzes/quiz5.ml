module IntSet = Set.Make(Int)

let q1_unique lst =
  IntSet.elements (IntSet.of_list lst)

class accumulator init = object
  val mutable total = init
  method add x = total <- total + x
  method get = total
end

let q2_rot13 (s : string) : string =
  let b = Bytes.of_string s in
  for i = 0 to Bytes.length b - 1 do
    let c = Bytes.get b i in
    let c' = match c with
      | 'a' .. 'z' -> Char.chr (Char.code 'a' + (Char.code c - Char.code 'a' + 13) mod 26)
      | 'A' .. 'Z' -> Char.chr (Char.code 'A' + (Char.code c - Char.code 'A' + 13) mod 26)
      | _ -> c
    in
    Bytes.set b i c'
  done;
  Bytes.to_string b

let ( let* ) = Result.bind

let q3_pipeline (input : string) : (int, string) result =
  let* n =
    match int_of_string_opt input with
    | Some n -> Ok n
    | None -> Error "parse error"
  in
  let* n =
    if n >= 1 && n <= 100 then Ok n else Error "out of range"
  in
  Ok (n * n)

let () =
  assert (q1_unique [3; 1; 4; 1; 5; 9; 2; 6; 5; 3] = [1; 2; 3; 4; 5; 6; 9]);

  let acc = new accumulator 0 in
  acc#add 10;
  acc#add 20;
  acc#add 30;
  assert (acc#get = 60);

  assert (q2_rot13 "Hello" = "Uryyb");
  assert (q2_rot13 "Uryyb" = "Hello");
  assert (q2_rot13 "abc 123" = "nop 123");

  assert (q3_pipeline "7" = Ok 49);
  assert (q3_pipeline "abc" = Error "parse error");
  assert (q3_pipeline "0" = Error "out of range");
  assert (q3_pipeline "101" = Error "out of range");

  print_endline "Quiz 5 complete!"
