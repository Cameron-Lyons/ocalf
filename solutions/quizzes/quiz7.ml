let q1_flat_map f lst =
  let rec aux acc = function
    | [] -> List.rev acc
    | x :: xs -> aux (List.rev_append (f x) acc) xs
  in
  aux [] lst

type 'a tree = Leaf | Node of 'a * 'a tree * 'a tree

let rec q2_tree_depth tree k =
  match tree with
  | Leaf -> k 0
  | Node (_, left, right) ->
    q2_tree_depth left (fun ld ->
      q2_tree_depth right (fun rd ->
        k (1 + max ld rd)))

type event = ..
type event += Log of string
type event += Metric of string * float

let q3_format_events events =
  List.map (function
    | Log msg -> "LOG: " ^ msg
    | Metric (name, value) -> Printf.sprintf "METRIC: %s=%.1f" name value
    | _ -> "UNKNOWN")
    events

module Option_monad = struct
  let return x = Some x
  let bind m f = match m with Some x -> f x | None -> None
  let ( let* ) = bind
end

let q4_safe_lookup keys tbl =
  let open Option_monad in
  let rec aux acc = function
    | [] -> return (List.rev acc)
    | k :: ks ->
      let* v = List.assoc_opt k tbl in
      aux (v :: acc) ks
  in
  aux [] keys

let () =
  assert (q1_flat_map (fun x -> [x; x * 10]) [1; 2; 3] = [1; 10; 2; 20; 3; 30]);
  assert (q1_flat_map (fun _ -> []) [1; 2; 3] = []);

  let t = Node (1, Node (2, Node (3, Leaf, Leaf), Leaf), Node (4, Leaf, Leaf)) in
  let depth = q2_tree_depth t (fun d -> d) in
  assert (depth = 3);
  assert (q2_tree_depth Leaf (fun d -> d) = 0);

  let events = [Log "start"; Metric ("cpu", 0.5); Log "end"] in
  assert (q3_format_events events = ["LOG: start"; "METRIC: cpu=0.5"; "LOG: end"]);

  let tbl = [("a", "1"); ("b", "2"); ("c", "3")] in
  assert (q4_safe_lookup ["a"; "b"] tbl = Some ["1"; "2"]);
  assert (q4_safe_lookup ["a"; "d"] tbl = None);
  assert (q4_safe_lookup [] tbl = Some []);

  print_endline "Quiz 7 complete!"
