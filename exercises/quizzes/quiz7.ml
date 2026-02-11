(* TODO: Quiz 7 - Tail Recursion, CPS, Extensible Variants, and Monads *)

let q1_flat_map f lst =
  ???
  (* Tail-recursively apply f to each element (f returns a list),
     flatten the results. Maintain order. *)

let q2_tree_depth tree =
  ???
  (* Compute the depth of a binary tree using CPS to avoid stack overflow.
     type 'a tree = Leaf | Node of 'a * 'a tree * 'a tree
     Leaf has depth 0. *)

type 'a tree = Leaf | Node of 'a * 'a tree * 'a tree

type event = ..
type event += Log of string
type event += Metric of string * float

let q3_format_events events =
  ???
  (* Map each event to a string:
     Log msg -> "LOG: " ^ msg
     Metric (name, value) -> Printf.sprintf "METRIC: %s=%.1f" name value
     _ -> "UNKNOWN"
     Return the list of strings. *)

module Option_monad = struct
  let return x = Some x
  let bind m f = match m with Some x -> f x | None -> None
  let ( let* ) = bind
end

let q4_safe_lookup keys tbl =
  let open Option_monad in
  ???
  (* Fold over the keys list. For each key, look it up in tbl (a (string * string) list)
     using List.assoc_opt. If any lookup fails, return None.
     If all succeed, return Some of the list of values. *)

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
