(* TODO: Use GADTs for a type-safe heterogeneous list and printf *)

type _ hlist =
  | HNil : unit hlist
  | HCons : 'a * 'b hlist -> ('a * 'b) hlist

let hd : type a b. (a * b) hlist -> a = function
  | HCons (x, _) -> ???  (* Return the head element *)

let tl : type a b. (a * b) hlist -> b hlist = function
  | HCons (_, rest) -> ???  (* Return the tail *)

type _ fmt =
  | Lit : string -> string fmt
  | SInt : 'a fmt -> (int -> 'a) fmt
  | SStr : 'a fmt -> (string -> 'a) fmt

let sprintf fmt =
  let rec go : type a. string -> a fmt -> a = fun acc -> function
    | Lit s -> ???  (* Concatenate acc and s *)
    | SInt rest -> ???  (* Return a function taking an int, then continue with go *)
    | SStr rest -> ???  (* Return a function taking a string, then continue with go *)
  in
  go "" fmt

let () =
  let lst = HCons (1, HCons ("hello", HCons (true, HNil))) in
  assert (hd lst = 1);
  assert (hd (tl lst) = "hello");
  assert (hd (tl (tl lst)) = true);

  assert (sprintf (Lit "hello") = "hello");
  assert (sprintf (SInt (Lit "")) 42 = "42");
  assert (sprintf (SStr (Lit "!")) "hi" = "hi!");
  assert (sprintf (SStr (SInt (Lit ""))) "x=" 5 = "x=5");

  print_endline "Advanced GADTs work!"
