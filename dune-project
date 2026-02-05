(lang dune 3.0)

(name ocalf)

(generate_opam_files true)

(source
 (github cameronlyons/ocalf))

(authors "Cameron Lyons")

(maintainers "Cameron Lyons")

(license MIT)

(documentation https://github.com/cameronlyons/ocalf)

(package
 (name ocalf)
 (synopsis "An OCaml training course")
 (description "A rustlings-style interactive learning course for OCaml")
 (depends
  (ocaml (>= 4.14))
  dune
  toml
  (cmdliner (>= 1.1.0))
  (inotify (and :with-test (>= 2.0)))
  (fileutils (>= 0.6.0))))
