(* TODO: Quiz 5 - Sets, Objects, Bytes, and Error Handling *)

module IntSet = Set.Make(Int)

let q1_unique lst =
  ???  (* Use IntSet to remove duplicates from lst, return as a sorted list *)

class accumulator init = object
  val mutable total = init
  method add x = ???  (* Add x to total *)
  method get = ???  (* Return total *)
end

let q2_rot13 (s : string) : string =
  let b = Bytes.of_string s in
  for i = 0 to Bytes.length b - 1 do
    let c = Bytes.get b i in
    let c' = match c with
      | 'a' .. 'z' -> ???  (* Rotate c by 13 within lowercase letters *)
      | 'A' .. 'Z' -> ???  (* Rotate c by 13 within uppercase letters *)
      | _ -> c
    in
    Bytes.set b i c'
  done;
  Bytes.to_string b

let ( let* ) = Result.bind

let q3_pipeline (input : string) : (int, string) result =
  ???
  (* Parse input as int, then check it's between 1 and 100 inclusive.
     Return Error "parse error" for bad input, Error "out of range" for invalid range.
     On success, return Ok of the value squared. *)

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
