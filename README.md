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

# Verify the current exercise
dune exec ocalf -- verify

# Verify a specific exercise
dune exec ocalf -- verify intro1

# Get a hint for the current exercise
dune exec ocalf -- hint

# Watch mode - auto-verify on file changes
dune exec ocalf -- watch

# Reset an exercise to its original state
dune exec ocalf -- reset intro1
```

## How It Works

1. Each exercise is an OCaml file in the `exercises/` directory
2. Exercises contain `(* TODO: ... *)` comments explaining what to fix
3. Edit the file to solve the exercise
4. Run `ocalf verify` to check your solution
5. Once verified, move on to the next exercise

## Topics

OCalf covers 70 exercises across 19 topics:

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
| -- | Quizzes | 3 |

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
