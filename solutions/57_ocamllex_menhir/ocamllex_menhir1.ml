type token =
  | INT of int
  | PLUS
  | STAR
  | LPAREN
  | RPAREN

let tokenize s =
  s
  |> String.split_on_char ' '
  |> List.filter (fun part -> part <> "")
  |> List.map (function
       | "+" -> PLUS
       | "*" -> STAR
       | "(" -> LPAREN
       | ")" -> RPAREN
       | n -> INT (int_of_string n))

let () =
  assert (
    tokenize "1 + 2 * ( 3 + 4 )"
    = [ INT 1; PLUS; INT 2; STAR; LPAREN; INT 3; PLUS; INT 4; RPAREN ]);
  print_endline "ocamllex/menhir scaffold 1 works!"
