(* TODO: Convert naive recursion to tail-recursive form with accumulators *)

let rec length_naive = function
  | [] -> 0
  | _ :: tl -> 1 + length_naive tl

let length lst =
  let rec aux acc = function
    | [] -> ???  (* Return the accumulator *)
    | _ :: tl -> ???  (* Recurse with acc + 1 *)
  in
  aux 0 lst

let reverse lst =
  let rec aux acc = function
    | [] -> ???  (* Return the accumulator *)
    | hd :: tl -> ???  (* Recurse with hd :: acc *)
  in
  aux [] lst

let map f lst =
  let rec aux acc = function
    | [] -> ???  (* Return reversed accumulator *)
    | hd :: tl -> ???  (* Recurse with f hd :: acc *)
  in
  aux [] lst

let () =
  let big = List.init 1_000_000 (fun i -> i) in
  assert (length big = 1_000_000);
  assert (length [] = 0);
  assert (length [1; 2; 3] = 3);

  assert (reverse [1; 2; 3] = [3; 2; 1]);
  assert (reverse [] = []);
  ignore (reverse big);

  assert (map (fun x -> x * 2) [1; 2; 3] = [2; 4; 6]);
  assert (map string_of_int [1; 2; 3] = ["1"; "2"; "3"]);
  ignore (map (fun x -> x + 1) big);

  print_endline "Tail recursion works!"
