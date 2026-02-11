type _ hlist =
  | HNil : unit hlist
  | HCons : 'a * 'b hlist -> ('a * 'b) hlist

let hd : type a b. (a * b) hlist -> a = function
  | HCons (x, _) -> x

let tl : type a b. (a * b) hlist -> b hlist = function
  | HCons (_, rest) -> rest

type _ fmt =
  | Lit : string -> string fmt
  | SInt : 'a fmt -> (int -> 'a) fmt
  | SStr : 'a fmt -> (string -> 'a) fmt

let sprintf fmt =
  let rec go : type a. string -> a fmt -> a = fun acc -> function
    | Lit s -> acc ^ s
    | SInt rest -> fun n -> go (acc ^ string_of_int n) rest
    | SStr rest -> fun s -> go (acc ^ s) rest
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
