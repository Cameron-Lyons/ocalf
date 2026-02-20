module User_id : sig
  type t = private int

  val make : int -> (t, string) result
  val of_string : string -> (t, string) result
  val succ : t -> t
  val to_int : t -> int
end = struct
  type t = int

  let make n =
    if n >= 0 then Ok n else Error "must be non-negative"

  let of_string s =
    match int_of_string_opt s with
    | None -> Error "not an int"
    | Some n -> make n

  let succ id = id + 1
  let to_int id = id
end

let () =
  (match User_id.make 12 with
  | Ok id -> assert (User_id.to_int id = 12)
  | Error _ -> assert false);
  assert (User_id.make (-1) = Error "must be non-negative");
  (match User_id.of_string "7" with
  | Ok id -> assert (User_id.to_int id = 7)
  | Error _ -> assert false);
  assert (User_id.of_string "oops" = Error "not an int");
  match User_id.of_string "20" with
  | Ok id -> assert (User_id.to_int (User_id.succ id) = 21)
  | Error _ -> assert false;
  print_endline "Private types work!"
