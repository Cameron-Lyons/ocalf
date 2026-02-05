module Calculator = struct
  let add x y = x + y
  let multiply x y = x * y
end

let q1_double_all lst =
  List.map (fun x -> x * 2) lst

let q1_keep_positive lst =
  List.filter (fun x -> x > 0) lst

let q2_sum lst =
  List.fold_left ( + ) 0 lst

let q3_compose f g x =
  f (g x)

let q4_pipeline x =
  x |> (fun n -> n + 1) |> (fun n -> n * 2) |> (fun n -> n - 3)

module type Stringify = sig
  type t
  val to_string : t -> string
end

module IntStringify : Stringify with type t = int = struct
  type t = int
  let to_string = string_of_int
end

let () =
  assert (Calculator.add 2 3 = 5);
  assert (Calculator.multiply 4 5 = 20);
  assert (q1_double_all [1; 2; 3] = [2; 4; 6]);
  assert (q1_keep_positive [-1; 2; -3; 4] = [2; 4]);
  assert (q2_sum [1; 2; 3; 4; 5] = 15);
  assert (q3_compose (fun x -> x + 1) (fun x -> x * 2) 5 = 11);
  assert (q4_pipeline 5 = 9);
  assert (IntStringify.to_string 42 = "42");
  print_endline "Quiz 3 complete!"
