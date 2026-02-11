(* TODO: Use phantom types for state machines *)

type unlocked
type locked

type _ door = Door : string -> _ door

let make_door name : unlocked door = ???  (* Create an unlocked Door *)

let lock : unlocked door -> locked door = fun (Door name) ->
  ???  (* Return a locked Door with the same name *)

let unlock : locked door -> unlocked door = fun (Door name) ->
  ???  (* Return an unlocked Door with the same name *)

let open_door : unlocked door -> string = fun (Door name) ->
  ???  (* Return name ^ " is open" - only works on unlocked doors! *)

let door_name : type a. a door -> string = fun (Door name) ->
  ???  (* Return the door name regardless of lock state *)

let () =
  let d = make_door "front" in
  assert (open_door d = "front is open");
  assert (door_name d = "front");

  let d_locked = lock d in
  assert (door_name d_locked = "front");
  (* open_door d_locked would not compile! *)

  let d_unlocked = unlock d_locked in
  assert (open_door d_unlocked = "front is open");

  print_endline "Phantom state machines work!"
