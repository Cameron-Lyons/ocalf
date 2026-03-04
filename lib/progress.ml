type attempt_result = Success | CompileError | RuntimeError

type entry = {
  exercise_id : string;
  completed : bool;
  attempts : int;
  last_result : attempt_result option;
  last_attempt_epoch : int option;
}

type state = {
  schema_version : int;
  workspace_root : string;
  workspace_fingerprint : string;
  entries : entry list;
}

type t = {
  path : string;
  workspace_root : string;
  workspace_fingerprint : string;
}

let schema_version = 1

let create ~path ~workspace_root ~workspace_fingerprint =
  { path; workspace_root; workspace_fingerprint }

let result_to_string = function
  | Success -> "success"
  | CompileError -> "compile_error"
  | RuntimeError -> "runtime_error"

let result_of_string = function
  | "success" -> Ok Success
  | "compile_error" -> Ok CompileError
  | "runtime_error" -> Ok RuntimeError
  | other ->
      Error
        (Printf.sprintf
           "invalid entry.last_result '%s' (expected \
            success|compile_error|runtime_error)"
           other)

let default_state store =
  {
    schema_version;
    workspace_root = store.workspace_root;
    workspace_fingerprint = store.workspace_fingerprint;
    entries = [];
  }

let escape_toml_string s =
  let buf = Buffer.create (String.length s) in
  String.iter
    (function
      | '\\' -> Buffer.add_string buf "\\\\"
      | '"' -> Buffer.add_string buf "\\\""
      | '\n' -> Buffer.add_string buf "\\n"
      | c -> Buffer.add_char buf c)
    s;
  Buffer.contents buf

let write_state store state =
  try
    let oc = open_out store.path in
    Printf.fprintf oc "schema_version = %d\n" state.schema_version;
    Printf.fprintf oc "workspace_root = \"%s\"\n"
      (escape_toml_string state.workspace_root);
    Printf.fprintf oc "workspace_fingerprint = \"%s\"\n\n"
      (escape_toml_string state.workspace_fingerprint);
    List.iter
      (fun entry ->
        Printf.fprintf oc "[[entry]]\n";
        Printf.fprintf oc "exercise_id = \"%s\"\n"
          (escape_toml_string entry.exercise_id);
        Printf.fprintf oc "completed = %s\n"
          (if entry.completed then "true" else "false");
        Printf.fprintf oc "attempts = %d\n" entry.attempts;
        (match entry.last_result with
        | None -> ()
        | Some r ->
            Printf.fprintf oc "last_result = \"%s\"\n" (result_to_string r));
        (match entry.last_attempt_epoch with
        | None -> ()
        | Some epoch -> Printf.fprintf oc "last_attempt_epoch = %d\n" epoch);
        output_char oc '\n')
      state.entries;
    close_out oc;
    Ok ()
  with exn ->
    Error
      (Printf.sprintf "failed to write state file '%s': %s" store.path
         (Printexc.to_string exn))

let load_state store : (state, string) result =
  let get_required_string ~field table =
    match Toml.Types.Table.find_opt (Toml.Min.key field) table with
    | Some (Toml.Types.TString s) when String.trim s <> "" -> Ok s
    | Some (Toml.Types.TString _) ->
        Error (Printf.sprintf "field '%s' cannot be empty" field)
    | Some _ -> Error (Printf.sprintf "field '%s' must be a string" field)
    | None -> Error (Printf.sprintf "missing required field '%s'" field)
  in
  let get_required_int ~field table =
    match Toml.Types.Table.find_opt (Toml.Min.key field) table with
    | Some (Toml.Types.TInt i) -> Ok i
    | Some _ -> Error (Printf.sprintf "field '%s' must be an integer" field)
    | None -> Error (Printf.sprintf "missing required field '%s'" field)
  in
  let get_required_bool ~field table =
    match Toml.Types.Table.find_opt (Toml.Min.key field) table with
    | Some (Toml.Types.TBool b) -> Ok b
    | Some _ -> Error (Printf.sprintf "field '%s' must be a boolean" field)
    | None -> Error (Printf.sprintf "missing required field '%s'" field)
  in
  let get_optional_string ~field table =
    match Toml.Types.Table.find_opt (Toml.Min.key field) table with
    | None -> Ok None
    | Some (Toml.Types.TString s) -> Ok (Some s)
    | Some _ -> Error (Printf.sprintf "field '%s' must be a string" field)
  in
  let get_optional_int ~field table =
    match Toml.Types.Table.find_opt (Toml.Min.key field) table with
    | None -> Ok None
    | Some (Toml.Types.TInt i) -> Ok (Some i)
    | Some _ -> Error (Printf.sprintf "field '%s' must be an integer" field)
  in
  if not (Sys.file_exists store.path) then Ok (default_state store)
  else
    try
      let toml = Toml.Parser.from_filename store.path |> Toml.Parser.unsafe in
      let version =
        match
          Toml.Types.Table.find_opt (Toml.Min.key "schema_version") toml
        with
        | Some (Toml.Types.TInt i) -> Ok i
        | Some _ -> Error "field 'schema_version' must be an integer"
        | None -> Error "missing required field 'schema_version'"
      in
      match version with
      | Error msg -> Error msg
      | Ok version_value -> (
          if version_value <> schema_version then
            Error
              (Printf.sprintf
                 "unsupported state schema_version %d (expected %d)"
                 version_value schema_version)
          else
            let workspace_root =
              match
                Toml.Types.Table.find_opt (Toml.Min.key "workspace_root") toml
              with
              | Some (Toml.Types.TString s) -> Ok s
              | Some _ -> Error "field 'workspace_root' must be a string"
              | None -> Error "missing required field 'workspace_root'"
            in
            let workspace_fp =
              match
                Toml.Types.Table.find_opt
                  (Toml.Min.key "workspace_fingerprint")
                  toml
              with
              | Some (Toml.Types.TString s) -> Ok s
              | Some _ -> Error "field 'workspace_fingerprint' must be a string"
              | None -> Error "missing required field 'workspace_fingerprint'"
            in
            match (workspace_root, workspace_fp) with
            | Error msg, _ | _, Error msg -> Error msg
            | Ok root, Ok fingerprint -> (
                if root <> store.workspace_root then
                  Error
                    (Printf.sprintf
                       "state workspace_root mismatch: expected '%s' but found \
                        '%s'"
                       store.workspace_root root)
                else if fingerprint <> store.workspace_fingerprint then
                  Error
                    "state workspace_fingerprint mismatch (delete state file \
                     to regenerate)"
                else
                  let entries =
                    match
                      Toml.Types.Table.find_opt (Toml.Min.key "entry") toml
                    with
                    | None -> Ok []
                    | Some (Toml.Types.TArray (Toml.Types.NodeTable tables)) ->
                        let rec collect idx seen acc = function
                          | [] -> Ok (List.rev acc)
                          | table :: rest -> (
                              match
                                ( get_required_string ~field:"exercise_id" table,
                                  get_required_bool ~field:"completed" table,
                                  get_required_int ~field:"attempts" table,
                                  get_optional_string ~field:"last_result" table,
                                  get_optional_int ~field:"last_attempt_epoch"
                                    table )
                              with
                              | Error msg, _, _, _, _
                              | _, Error msg, _, _, _
                              | _, _, Error msg, _, _
                              | _, _, _, Error msg, _
                              | _, _, _, _, Error msg ->
                                  Error (Printf.sprintf "entry[%d] %s" idx msg)
                              | ( Ok exercise_id,
                                  Ok completed,
                                  Ok attempts,
                                  Ok last_result_raw,
                                  Ok last_attempt_epoch ) -> (
                                  if List.mem exercise_id seen then
                                    Error
                                      (Printf.sprintf
                                         "duplicate entry.exercise_id '%s'"
                                         exercise_id)
                                  else
                                    let last_result =
                                      match last_result_raw with
                                      | None -> Ok None
                                      | Some r ->
                                          result_of_string r
                                          |> Result.map (fun parsed ->
                                              Some parsed)
                                    in
                                    match last_result with
                                    | Error msg ->
                                        Error
                                          (Printf.sprintf "entry[%d] %s" idx msg)
                                    | Ok last_result_value ->
                                        collect (idx + 1) (exercise_id :: seen)
                                          ({
                                             exercise_id;
                                             completed;
                                             attempts;
                                             last_result = last_result_value;
                                             last_attempt_epoch;
                                           }
                                          :: acc)
                                          rest))
                        in
                        collect 0 [] [] tables
                    | Some _ -> Error "field 'entry' must be an array of tables"
                  in
                  match entries with
                  | Error msg -> Error msg
                  | Ok parsed_entries ->
                      Ok
                        {
                          schema_version;
                          workspace_root = root;
                          workspace_fingerprint = fingerprint;
                          entries = parsed_entries;
                        }))
    with exn ->
      Error
        (Printf.sprintf "failed to parse state file '%s': %s" store.path
           (Printexc.to_string exn))

let load = load_state
let save store state = write_state store state

let map_entry entries exercise_id f =
  let rec loop acc = function
    | [] -> List.rev acc
    | entry :: rest ->
        if entry.exercise_id = exercise_id then loop (f entry :: acc) rest
        else loop (entry :: acc) rest
  in
  loop [] entries

let upsert_entry entries new_entry =
  if List.exists (fun e -> e.exercise_id = new_entry.exercise_id) entries then
    map_entry entries new_entry.exercise_id (fun _ -> new_entry)
  else new_entry :: entries

let record_attempt store ~exercise_id ~result =
  match load_state store with
  | Error msg -> Error msg
  | Ok state ->
      let prior =
        List.find_opt (fun e -> e.exercise_id = exercise_id) state.entries
      in
      let attempts =
        match prior with None -> 1 | Some entry -> entry.attempts + 1
      in
      let completed =
        match prior with
        | None -> result = Success
        | Some entry -> entry.completed || result = Success
      in
      let entry =
        {
          exercise_id;
          completed;
          attempts;
          last_result = Some result;
          last_attempt_epoch = Some (int_of_float (Unix.time ()));
        }
      in
      save store { state with entries = upsert_entry state.entries entry }

let reset store exercise_id =
  match load_state store with
  | Error msg -> Error msg
  | Ok state ->
      let filtered =
        List.filter (fun e -> e.exercise_id <> exercise_id) state.entries
      in
      save store { state with entries = filtered }

let reset_all store =
  if Sys.file_exists store.path then
    try
      Sys.remove store.path;
      Ok ()
    with exn ->
      Error
        (Printf.sprintf "failed to remove state file '%s': %s" store.path
           (Printexc.to_string exn))
  else Ok ()

let completed_ids store =
  match load_state store with
  | Error msg -> Error msg
  | Ok state ->
      Ok
        (List.fold_left
           (fun acc entry ->
             if entry.completed then entry.exercise_id :: acc else acc)
           [] state.entries)

let is_done store exercise_id =
  match completed_ids store with
  | Error msg -> Error msg
  | Ok ids -> Ok (List.mem exercise_id ids)

let get_current store exercises =
  match completed_ids store with
  | Error msg -> Error msg
  | Ok completed ->
      Ok
        (List.find_opt
           (fun (ex : Exercise.t) -> not (List.mem ex.id completed))
           exercises)

let count_completed store exercises =
  match completed_ids store with
  | Error msg -> Error msg
  | Ok completed ->
      Ok
        (List.length
           (List.filter
              (fun (ex : Exercise.t) -> List.mem ex.id completed)
              exercises))
