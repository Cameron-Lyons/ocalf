module type Greeter = sig
  val greet : string -> string
end

module EnglishGreeter : Greeter = struct
  let greet name = "Hello, " ^ name
end

module SpanishGreeter : Greeter = struct
  let greet name = "Hola, " ^ name
end

let () =
  assert (EnglishGreeter.greet "Alice" = "Hello, Alice");
  assert (SpanishGreeter.greet "Alice" = "Hola, Alice");
  print_endline "Module signatures work!"
