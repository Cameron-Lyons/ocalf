module Option_syntax = struct
  let ( let* ) = Option.bind
  let return x = Some x
end

let safe_div x y = if y = 0 then None else Some (x / y)

let compute a b c =
  let open Option_syntax in
  let* x = safe_div a b in
  let* y = safe_div x c in
  return (y + 1)

let () =
  assert (compute 20 2 5 = Some 3);
  assert (compute 20 0 5 = None);
  assert (compute 20 2 0 = None);
  print_endline "let* for Option works!"
