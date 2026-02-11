(* TODO: Use object subtyping and coercion *)

class type printable = object
  method to_string : string
end

class int_box (n : int) = object
  method to_string = ???  (* Return string_of_int n *)
  method value = ???  (* Return n *)
end

class string_box (s : string) = object
  method to_string = ???  (* Return s *)
  method length = ???  (* Return String.length s *)
end

let print_it (obj : printable) : string =
  ???  (* Call obj#to_string *)

let () =
  let ib = new int_box 42 in
  assert (ib#value = 42);
  assert (ib#to_string = "42");

  let sb = new string_box "hello" in
  assert (sb#length = 5);
  assert (sb#to_string = "hello");

  let p1 : printable = ???  (* Coerce ib to printable using :> *)
  in
  assert (print_it p1 = "42");

  let p2 : printable = ???  (* Coerce sb to printable using :> *)
  in
  assert (print_it p2 = "hello");

  let items : printable list = ???  (* Create a list of [ib; sb] coerced to printable *)
  in
  let strs = List.map (fun p -> p#to_string) items in
  assert (strs = ["42"; "hello"]);

  print_endline "Object coercion works!"
