(* TODO [Easy]: Implement table-driven tests with useful failure messages *)

type ('a, 'b) test_case =
  {
    name : string;
    input : 'a;
    expected : 'b;
  }

let run_case ~eq ~show f c =
  let actual = f c.input in
  if eq actual c.expected then Ok ()
  else
    Error
      (Printf.sprintf "%s: expected %s but got %s" c.name (show c.expected)
         (show actual))

let run_all ~eq ~show f cases =
  ???  (* Return list of error messages, preserving case order *)

let () =
  let square x = x * x in
  let cases =
    [
      { name = "square-2"; input = 2; expected = 4 };
      { name = "square-3"; input = 3; expected = 9 };
      { name = "square-5"; input = 5; expected = 25 };
    ]
  in
  assert (run_all ~eq:Int.equal ~show:string_of_int square cases = []);
  print_endline "Testing scaffold 1 works!"
