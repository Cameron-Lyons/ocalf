type unlocked
type locked

type _ door = Door : string -> _ door

let make_door name : unlocked door = Door name

let lock : unlocked door -> locked door = fun (Door name) ->
  Door name

let unlock : locked door -> unlocked door = fun (Door name) ->
  Door name

let open_door : unlocked door -> string = fun (Door name) ->
  name ^ " is open"

let door_name : type a. a door -> string = fun (Door name) ->
  name

let () =
  let d = make_door "front" in
  assert (open_door d = "front is open");
  assert (door_name d = "front");

  let d_locked = lock d in
  assert (door_name d_locked = "front");

  let d_unlocked = unlock d_locked in
  assert (open_door d_unlocked = "front is open");

  print_endline "Phantom state machines work!"
