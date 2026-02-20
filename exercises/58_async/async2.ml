(* TODO [Medium]: Implement bind for a tiny result task monad *)

type 'a task = unit -> ('a, string) result

let return x () = Ok x
let fail msg () = Error msg

let bind t f () =
  ???
  (* Run t (); on Ok x run f x (); on Error e, propagate Error e *)

let ( let* ) = bind

let read_positive n =
  if n > 0 then return n else fail "non-positive"

let () =
  let program_ok =
    let* a = read_positive 3 in
    let* b = read_positive 4 in
    return (a + b)
  in
  let program_err =
    let* a = read_positive 3 in
    let* b = read_positive (-1) in
    return (a + b)
  in
  assert (program_ok () = Ok 7);
  assert (program_err () = Error "non-positive");
  print_endline "Async scaffold 2 works!"
