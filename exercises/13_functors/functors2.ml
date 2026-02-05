(* TODO: Apply a functor to create different modules *)

module type Printable = sig
  type t
  val to_string : t -> string
end

module MakePrinter (P : Printable) = struct
  let print x = print_endline (P.to_string x)
  let format x = "Value: " ^ P.to_string x
end

module IntPrintable = ???  (* Implement Printable for int using string_of_int *)

module IntPrinter = MakePrinter(IntPrintable)

let () =
  assert (IntPrinter.format 42 = "Value: 42");
  print_endline "Functor application works!"
