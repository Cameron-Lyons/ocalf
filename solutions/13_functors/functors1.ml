module type HasValue = sig
  val x : int
end

module AddOne (M : HasValue) = struct
  let result = M.x + 1
end

module Five = struct
  let x = 5
end

module Six = AddOne(Five)

let () =
  assert (Six.result = 6);
  print_endline "Functor definition works!"
