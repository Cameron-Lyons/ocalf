(* TODO: Quiz 3 - Modules and Higher-Order Programming *)

module Calculator = struct
  let add x y = ???  (* Add x and y *)
  let multiply x y = ???  (* Multiply x and y *)
end

let q1_double_all lst =
  ???  (* Use List.map to double each element *)

let q1_keep_positive lst =
  ???  (* Use List.filter to keep only positive numbers *)

let q2_sum lst =
  ???  (* Use List.fold_left to sum the list *)

let q3_compose f g x =
  ???  (* Return f(g(x)) *)

let q4_pipeline x =
  x |> ???  (* Use pipeline to: add 1, multiply by 2, subtract 3 *)

module type Stringify = sig
  type t
  val to_string : t -> string
end

module IntStringify : ??? = struct
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
