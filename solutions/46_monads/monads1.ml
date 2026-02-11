module Writer : sig
  type 'a t
  val return : 'a -> 'a t
  val bind : 'a t -> ('a -> 'b t) -> 'b t
  val tell : string -> unit t
  val run : 'a t -> 'a * string list
end = struct
  type 'a t = 'a * string list

  let return x = (x, [])

  let bind (x, log1) f =
    let (y, log2) = f x in
    (y, log1 @ log2)

  let tell msg = ((), [msg])

  let run t = t
end

let ( let* ) = Writer.bind

let validated_divide a b =
  if b = 0 then begin
    let* () = Writer.tell "division by zero, returning 0" in
    Writer.return 0
  end else begin
    let* () = Writer.tell (Printf.sprintf "%d / %d = %d" a b (a / b)) in
    Writer.return (a / b)
  end

let () =
  let (result, log) = Writer.run (
    let* x = Writer.return 10 in
    let* () = Writer.tell "starting" in
    let* y = validated_divide x 3 in
    let* z = validated_divide y 0 in
    let* () = Writer.tell "done" in
    Writer.return (y + z)
  ) in
  assert (result = 3);
  assert (log = ["starting"; "10 / 3 = 3"; "division by zero, returning 0"; "done"]);

  print_endline "Writer monad works!"
