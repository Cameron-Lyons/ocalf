(* TODO: Use open and include with modules *)

module Utils = struct
  let double x = x * 2
  let triple x = x * 3
end

module ExtendedUtils = struct
  ??? (* Include Utils here *)
  let quadruple x = x * 4
end

let () =
  let open Utils in  (* Open Utils locally *)
  assert (double 5 = 10);
  assert (triple 5 = 15);

  assert (ExtendedUtils.double 5 = 10);
  assert (ExtendedUtils.quadruple 5 = 20);
  print_endline "Open and include work!"
