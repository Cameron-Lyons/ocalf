(* TODO: Chain optional operations *)

let find_user id =
  if id = 1 then Some "Alice"
  else if id = 2 then Some "Bob"
  else None

let get_email name =
  if name = "Alice" then Some "alice@example.com"
  else None

let get_user_email id =
  ??? (* Chain find_user and get_email using Option.bind *)

let () =
  assert (get_user_email 1 = Some "alice@example.com");
  assert (get_user_email 2 = None);
  assert (get_user_email 3 = None);
  print_endline "Option chaining works!"
