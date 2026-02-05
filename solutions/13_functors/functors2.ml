module type Printable = sig
  type t
  val to_string : t -> string
end

module MakePrinter (P : Printable) = struct
  let print x = print_endline (P.to_string x)
  let format x = "Value: " ^ P.to_string x
end

module IntPrintable : Printable with type t = int = struct
  type t = int
  let to_string = string_of_int
end

module IntPrinter = MakePrinter(IntPrintable)

let () =
  assert (IntPrinter.format 42 = "Value: 42");
  print_endline "Functor application works!"
