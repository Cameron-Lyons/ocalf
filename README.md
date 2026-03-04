# OCalf

An interactive OCaml training course inspired by [rustlings](https://github.com/rust-lang/rustlings).

## Installation

### Prerequisites

You need OCaml and opam installed. On most systems:

```bash
# macOS
brew install opam
opam init

# Ubuntu/Debian
apt install opam
opam init

# Arch Linux
pacman -S opam
opam init
```

### Setup

```bash
# Clone the repository
git clone https://github.com/cameronlyons/ocalf.git
cd ocalf

# Install dependencies
opam install . --deps-only

# Build
dune build
```

## Usage

```bash
# Show current progress and available commands
dune exec ocalf

# List all exercises
dune exec ocalf -- list

# Verify the next incomplete exercise (explicit target)
dune exec ocalf -- verify next

# Verify a specific exercise
dune exec ocalf -- verify intro1

# Get a hint for the next incomplete exercise
dune exec ocalf -- hint next

# Get machine-readable output
dune exec ocalf -- list --json

# Compact JSON summary (default mode) or full exercise payload
dune exec ocalf -- list --json --json-mode summary
dune exec ocalf -- list --json --json-mode full

# Watch mode - auto-verify on file changes
dune exec ocalf -- watch next

# Reset an exercise to its original state
dune exec ocalf -- reset intro1
```

## How It Works

1. The exercise manifest (`exercises/info.toml`) uses `schema_version = 3`
2. Each exercise entry declares `id`, `path`, `topic`, `difficulty`, `hint`, and `check`
3. Edit an exercise file in `exercises/`
4. Run `ocalf verify <id|next>` to run that exercise's declared check contract
5. Progress is stored in `.ocalf-state.toml` with attempts and last result metadata

### Check contracts

`check` supports:
- `compile_and_run` (default OCaml compile + execute behavior)
- `command` with `check_command = ["prog", "arg1", ...]`

`check_command` placeholders:
- `{project_root}` absolute project root
- `{exercise_id}` exercise id
- `{exercise_path}` absolute path to the exercise file

## Topics

OCalf covers 190 exercises across 63 topics:

| # | Topic | Exercises |
|---|-------|-----------|
| 00 | Intro | 2 |
| 01 | Variables | 4 |
| 02 | Functions | 5 |
| 03 | If Expressions | 3 |
| 04 | Primitive Types | 4 |
| 05 | Tuples | 3 |
| 06 | Records | 4 |
| 07 | Variants | 4 |
| 08 | Pattern Matching | 5 |
| 09 | Lists | 5 |
| 10 | Options | 4 |
| 11 | Results | 4 |
| 12 | Modules | 5 |
| 13 | Functors | 4 |
| 14 | Higher-Order Functions | 5 |
| 15 | Recursion | 4 |
| 16 | Refs | 3 |
| 17 | Exceptions | 3 |
| 18 | Arrays | 3 |
| 19 | Imperative Programming | 3 |
| 20 | Let Operators | 2 |
| 21 | File I/O | 2 |
| 22 | Printf | 2 |
| 23 | Strings | 3 |
| 24 | Sequences | 3 |
| 25 | Hash Tables | 3 |
| 26 | Maps | 3 |
| 27 | Polymorphic Variants | 3 |
| 28 | GADTs | 2 |
| 29 | Lazy Evaluation | 2 |
| 30 | Sets | 3 |
| 31 | Objects | 3 |
| 32 | Bytes | 2 |
| 33 | Phantom Types | 2 |
| 34 | Mutual Recursion | 2 |
| 35 | Error Handling | 2 |
| 36 | Closures | 3 |
| 37 | Applicatives | 2 |
| 38 | Queues and Stacks | 2 |
| 39 | Format | 2 |
| 40 | Type Annotations | 3 |
| 41 | Local Opens | 2 |
| 42 | Tail Recursion | 3 |
| 43 | Functorial Design | 2 |
| 44 | CPS | 2 |
| 45 | Extensible Variants | 2 |
| 46 | Monads | 2 |
| 47 | Effect Handlers | 2 |
| 48 | Domains and Atomics | 2 |
| 49 | Recursive Modules | 2 |
| 50 | OO Inheritance | 2 |
| 51 | FFI Interop | 2 |
| 52 | Parsing and Rewriting | 2 |
| 53 | Value Restriction | 3 |
| 54 | Variance + Private Types | 3 |
| 55 | Advanced Modules | 4 |
| 56 | PPX + Dune | 3 |
| 57 | Ocamllex + Menhir | 4 |
| 58 | Async | 3 |
| 59 | Real FFI (stubs/ctypes) | 3 |
| 60 | Testing + Property Testing | 3 |
| 61 | Performance + GC | 3 |
| -- | Quizzes | 8 |

## Exercise Format

Each exercise file contains:
- A `(* TODO: ... *)` comment explaining the task
- Incomplete or broken code to fix
- Assertions that verify the solution

Example:

```ocaml
(* TODO: Bind the value 5 to the variable x *)

let () =
  let x = ??? in
  assert (x = 5);
  print_endline "Success!"
```

## Solutions

Solutions are available in the `solutions/` directory. Try to solve exercises on your own first!

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

MIT
