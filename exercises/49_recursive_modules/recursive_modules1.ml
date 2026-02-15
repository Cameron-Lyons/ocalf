(* TODO: Complete mutually recursive modules Even and Odd *)

module rec Even : sig
  val is_even : int -> bool
end = struct
  let rec is_even n =
    if n = 0 then true else ???
end
and Odd : sig
  val is_odd : int -> bool
end = struct
  let rec is_odd n =
    if n = 0 then false else ???
end

let () =
  assert (Even.is_even 0);
  assert (Even.is_even 10);
  assert (not (Even.is_even 11));
  assert (Odd.is_odd 11);
  assert (not (Odd.is_odd 10));
  print_endline "Recursive modules work!"
