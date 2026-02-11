(* TODO: Implement a State monad *)

module State : sig
  type ('s, 'a) t
  val return : 'a -> ('s, 'a) t
  val bind : ('s, 'a) t -> ('a -> ('s, 'b) t) -> ('s, 'b) t
  val get : ('s, 's) t
  val put : 's -> ('s, unit) t
  val modify : ('s -> 's) -> ('s, unit) t
  val run : ('s, 'a) t -> 's -> 'a * 's
end = struct
  type ('s, 'a) t = 's -> 'a * 's

  let return x = ???  (* Return a function that pairs x with the unchanged state *)

  let bind m f = ???  (* Run m, then pass the result to f, threading state through *)

  let get = ???  (* Return a function that returns the state as both value and state *)

  let put s = ???  (* Return a function that ignores old state and sets s *)

  let modify f = ???  (* Return a function that applies f to the state *)

  let run m s = ???  (* Apply m to s *)
end

let ( let* ) = State.bind

let push x =
  State.modify (fun stack -> x :: stack)

let pop =
  let* stack = State.get in
  match stack with
  | [] -> failwith "empty stack"
  | hd :: tl ->
    let* () = State.put tl in
    State.return hd

let () =
  let program =
    let* () = push 1 in
    let* () = push 2 in
    let* () = push 3 in
    let* x = pop in
    let* y = pop in
    State.return (x + y)
  in
  let (result, remaining) = State.run program [] in
  assert (result = 5);
  assert (remaining = [1]);

  let counter =
    let* () = State.modify (fun n -> n + 1) in
    let* () = State.modify (fun n -> n + 1) in
    let* () = State.modify (fun n -> n + 1) in
    State.get
  in
  let (count, _) = State.run counter 0 in
  assert (count = 3);

  print_endline "State monad works!"
