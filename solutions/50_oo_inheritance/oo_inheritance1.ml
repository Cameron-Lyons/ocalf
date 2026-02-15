class virtual shape = object (self)
  method virtual area : float
  method describe = Printf.sprintf "area=%.1f" self#area
end

class rectangle w h = object
  inherit shape
  method area = w *. h
end

class square s = object
  inherit rectangle s s
end

let () =
  let r = new rectangle 3.0 4.0 in
  let s = new square 5.0 in
  assert (r#area = 12.0);
  assert (s#area = 25.0);
  assert (s#describe = "area=25.0");
  print_endline "OO inheritance works!"
