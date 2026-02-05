(* TODO: Define a module signature and apply it to a module *)

module type Greeter = sig
  val greet : string -> string
end

module EnglishGreeter = ???  (* Implement Greeter with greet returning "Hello, " ^ name *)

module SpanishGreeter = ???  (* Implement Greeter with greet returning "Hola, " ^ name *)

let () =
  assert (EnglishGreeter.greet "Alice" = "Hello, Alice");
  assert (SpanishGreeter.greet "Alice" = "Hola, Alice");
  print_endline "Module signatures work!"
