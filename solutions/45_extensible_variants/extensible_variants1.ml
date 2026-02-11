type event = ..

type event += Click
type event += KeyPress of char
type event += Resize of int * int

let describe_event = function
  | Click -> "click"
  | KeyPress c -> Printf.sprintf "key:%c" c
  | Resize (w, h) -> Printf.sprintf "resize:%dx%d" w h
  | _ -> "unknown"

type event += Scroll of int

let describe_event_v2 = function
  | Scroll n -> Printf.sprintf "scroll:%d" n
  | e -> describe_event e

let () =
  assert (describe_event Click = "click");
  assert (describe_event (KeyPress 'a') = "key:a");
  assert (describe_event (Resize (800, 600)) = "resize:800x600");

  assert (describe_event_v2 (Scroll 42) = "scroll:42");
  assert (describe_event_v2 Click = "click");
  assert (describe_event_v2 (KeyPress 'z') = "key:z");

  print_endline "Extensible variants work!"
