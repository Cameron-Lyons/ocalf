module type Show = sig
  type t
  val show : t -> string
  val compare : t -> t -> int
end

module type Int_show = Show with type t := int

module Int_show_impl : Int_show = struct
  let show = string_of_int
  let compare = Int.compare
end

let render_sorted_unique xs =
  xs
  |> List.sort_uniq Int_show_impl.compare
  |> List.map Int_show_impl.show

let () =
  assert (render_sorted_unique [ 3; 1; 3; 2 ] = [ "1"; "2"; "3" ]);
  print_endline "Advanced modules (destructive substitution) works!"
