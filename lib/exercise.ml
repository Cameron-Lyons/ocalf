type difficulty = Beginner | Intermediate | Advanced
type check = CompileAndRun | Command of string list

type t = {
  id : string;
  path : string;
  topic : string;
  difficulty : difficulty;
  hint : string;
  check : check;
}

let schema_version = 3

let difficulty_to_string = function
  | Beginner -> "beginner"
  | Intermediate -> "intermediate"
  | Advanced -> "advanced"

let difficulty_of_string = function
  | "beginner" -> Ok Beginner
  | "intermediate" -> Ok Intermediate
  | "advanced" -> Ok Advanced
  | other ->
      Error
        (Printf.sprintf
           "invalid difficulty '%s' (expected beginner|intermediate|advanced)"
           other)

let check_to_string = function
  | CompileAndRun -> "compile_and_run"
  | Command _ -> "command"

let check_to_human = function
  | CompileAndRun -> "compile_and_run"
  | Command argv -> Printf.sprintf "command(%s)" (String.concat " " argv)

let exercise_path ~exercises_dir exercise =
  Filename.concat exercises_dir exercise.path

let solution_path ~solutions_dir exercise =
  Filename.concat solutions_dir exercise.path

let parse_info_toml path : (t list, string) result =
  let ( let* ) result f =
    match result with Ok value -> f value | Error msg -> Error msg
  in
  let get_required_string ~field table =
    match Toml.Types.Table.find_opt (Toml.Min.key field) table with
    | Some (Toml.Types.TString s) when String.trim s <> "" -> Ok s
    | Some (Toml.Types.TString _) ->
        Error (Printf.sprintf "field '%s' cannot be empty" field)
    | Some _ -> Error (Printf.sprintf "field '%s' must be a string" field)
    | None -> Error (Printf.sprintf "missing required field '%s'" field)
  in
  let get_required_string_array ~field table =
    match Toml.Types.Table.find_opt (Toml.Min.key field) table with
    | Some (Toml.Types.TArray (Toml.Types.NodeString values))
      when values <> []
           && List.for_all (fun value -> String.trim value <> "") values ->
        Ok values
    | Some (Toml.Types.TArray (Toml.Types.NodeString [])) ->
        Error (Printf.sprintf "field '%s' cannot be an empty array" field)
    | Some (Toml.Types.TArray (Toml.Types.NodeString _)) ->
        Error (Printf.sprintf "field '%s' cannot contain empty strings" field)
    | Some _ ->
        Error
          (Printf.sprintf "field '%s' must be an array of strings" field)
    | None ->
        Error (Printf.sprintf "missing required field '%s'" field)
  in
  let parse_one index table =
    let open Result in
    let* id = get_required_string ~field:"id" table in
    let* path = get_required_string ~field:"path" table in
    let* topic = get_required_string ~field:"topic" table in
    let* difficulty_raw = get_required_string ~field:"difficulty" table in
    let* difficulty =
      difficulty_of_string difficulty_raw
      |> Result.map_error (fun msg ->
          Printf.sprintf "exercise[%d] %s" index msg)
    in
    let* check_raw = get_required_string ~field:"check" table in
    let* check =
      match check_raw with
      | "compile_and_run" -> Ok CompileAndRun
      | "command" ->
          let* argv =
            get_required_string_array ~field:"check_command" table
            |> Result.map_error (fun msg ->
                   Printf.sprintf "exercise[%d] %s" index msg)
          in
          Ok (Command argv)
      | other ->
          Error
            (Printf.sprintf
               "exercise[%d] invalid check '%s' (expected \
                compile_and_run|command)"
               index other)
    in
    let* hint = get_required_string ~field:"hint" table in
    if Filename.is_relative path then
      if Filename.extension path = ".ml" then
        Ok { id; path; topic; difficulty; hint; check }
      else
        Error
          (Printf.sprintf
             "exercise[%d] field 'path' must end with .ml (got '%s')" index path)
    else
      Error
        (Printf.sprintf "exercise[%d] field 'path' must be relative (got '%s')"
           index path)
  in
  try
    let toml = Toml.Parser.from_filename path |> Toml.Parser.unsafe in
    let open Result in
    let* version =
      match Toml.Types.Table.find_opt (Toml.Min.key "schema_version") toml with
      | Some (Toml.Types.TInt i) -> Ok i
      | Some _ -> Error "field 'schema_version' must be an integer"
      | None -> Error "missing required field 'schema_version'"
    in
    if version <> schema_version then
      Error
        (Printf.sprintf "unsupported schema_version %d (expected %d)" version
           schema_version)
    else
      let* exercise_tables =
        match Toml.Types.Table.find_opt (Toml.Min.key "exercise") toml with
        | Some (Toml.Types.TArray (Toml.Types.NodeTable tables)) -> Ok tables
        | Some _ -> Error "field 'exercise' must be an array of tables"
        | None -> Error "missing required array-of-table 'exercise'"
      in
      let rec collect idx seen_ids acc = function
        | [] -> Ok (List.rev acc)
        | table :: rest -> (
            match parse_one idx table with
            | Error msg -> Error msg
            | Ok exercise ->
                if List.mem exercise.id seen_ids then
                  Error
                    (Printf.sprintf "duplicate exercise id '%s'" exercise.id)
                else
                  collect (idx + 1) (exercise.id :: seen_ids) (exercise :: acc)
                    rest)
      in
      collect 0 [] [] exercise_tables
  with exn ->
    Error
      (Printf.sprintf "failed to parse manifest '%s': %s" path
         (Printexc.to_string exn))
