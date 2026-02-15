module rec Even : sig
  val is_even : int -> bool
end = struct
  let rec is_even n =
    if n = 0 then true else Odd.is_odd (n - 1)
end
and Odd : sig
  val is_odd : int -> bool
end = struct
  let rec is_odd n =
    if n = 0 then false else Even.is_even (n - 1)
end

let () =
  assert (Even.is_even 0);
  assert (Even.is_even 10);
  assert (not (Even.is_even 11));
  assert (Odd.is_odd 11);
  assert (not (Odd.is_odd 10));
  print_endline "Recursive modules work!"
