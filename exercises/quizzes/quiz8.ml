(* TODO: Quiz 8 - Value Restriction, Advanced Modules, Parsing, and Property Testing *)

let make_mapper f = List.map f

let q1_id_map =
  ???
  (* Keep this polymorphic by using eta-expansion (function form),
     not a bare partial application. *)

module type Counter = sig
  val name : string
  val count : int
end

let q2_total_and_heavy threshold mods =
  ???
  (* Unpack first-class modules and return:
     (sum of all counts, names with count >= threshold in original order) *)

type token =
  | INT of int
  | PLUS
  | STAR

let q3_eval tokens =
  let rec parse_term acc = function
    | STAR :: INT n :: rest -> parse_term (acc * n) rest
    | rest -> (acc, rest)
  in
  let rec parse_expr acc = function
    | PLUS :: INT n :: rest ->
        let term, rest' = parse_term n rest in
        ???  (* continue accumulating with acc + term *)
    | [] -> acc
    | _ -> failwith "invalid expression"
  in
  match tokens with
  | INT n :: rest ->
      let first_term, rest' = parse_term n rest in
      parse_expr first_term rest'
  | _ -> failwith "expression must start with INT"

type 'a prop_result =
  | Pass
  | Fail of
      {
        trial : int;
        value : 'a;
      }

let rec shrink_fail ~pred ~shrink x =
  match shrink x with
  | Some x' when not (pred x') -> shrink_fail ~pred ~shrink x'
  | _ -> x

let q4_check_forall ~trials ~gen ~pred ~shrink =
  ???
  (* Run trials deterministically with gen 0..gen (trials-1).
     Return Pass if all satisfy pred.
     On first failure, return Fail with trial index and shrunk value. *)

module A = struct
  let name = "a"
  let count = 2
end

module B = struct
  let name = "b"
  let count = 7
end

module C = struct
  let name = "c"
  let count = 5
end

let () =
  assert (q1_id_map [ 1; 2; 3 ] = [ 1; 2; 3 ]);
  assert (q1_id_map [ "x"; "y" ] = [ "x"; "y" ]);

  let total, heavy =
    q2_total_and_heavy 5
      [ (module A : Counter); (module B : Counter); (module C : Counter) ]
  in
  assert (total = 14);
  assert (heavy = [ "b"; "c" ]);

  assert (q3_eval [ INT 1; PLUS; INT 2; STAR; INT 3; PLUS; INT 4 ] = 11);
  assert (q3_eval [ INT 2; STAR; INT 3; STAR; INT 4 ] = 24);

  let res1 =
    q4_check_forall ~trials:15 ~gen:(fun i -> i) ~pred:(fun x -> x >= 0)
      ~shrink:(fun x -> if x > 0 then Some (x - 1) else None)
  in
  assert (res1 = Pass);

  let res2 =
    q4_check_forall ~trials:30 ~gen:(fun i -> i) ~pred:(fun x -> x * x <= 100)
      ~shrink:(fun x -> if x > 0 then Some (x - 1) else None)
  in
  assert (res2 = Fail { trial = 11; value = 11 });

  print_endline "Quiz 8 complete!"
