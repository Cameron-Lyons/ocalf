type shape =
  | Circle of float
  | Rectangle of float * float
  | Triangle of float * float

let q1_pair = (42, "answer")

type person = { name : string; age : int }

let q2_person = { name = "Bob"; age = 25 }

let q3_area shape =
  match shape with
  | Circle r -> 3.14159 *. r *. r
  | Rectangle (w, h) -> w *. h
  | Triangle (base, height) -> 0.5 *. base *. height

let q4_list_info lst =
  match lst with
  | [] -> "empty"
  | [_] -> "singleton"
  | [_; _] -> "pair"
  | _ -> "many"

let q5_safe_head lst =
  match lst with
  | [] -> None
  | x :: _ -> Some x

let () =
  assert (q1_pair = (42, "answer"));
  assert (q2_person.name = "Bob");
  assert (q2_person.age = 25);
  assert (abs_float (q3_area (Circle 2.0) -. 12.56636) < 0.001);
  assert (q3_area (Rectangle (3.0, 4.0)) = 12.0);
  assert (q3_area (Triangle (6.0, 4.0)) = 12.0);
  assert (q4_list_info [] = "empty");
  assert (q4_list_info [1] = "singleton");
  assert (q4_list_info [1; 2] = "pair");
  assert (q4_list_info [1; 2; 3] = "many");
  assert (q5_safe_head [1; 2; 3] = Some 1);
  assert (q5_safe_head [] = None);
  print_endline "Quiz 2 complete!"
