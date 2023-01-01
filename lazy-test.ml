#!/usr/bin/env ocaml

(*
  Demonstrates how to use Seq for lazy evaluation. Usage:

  ```bash
  ./lazy-test.ml foo bar whatever 2> /dev/null
  ```

  This will output the following:

  ```
  0: "/var/home/phil/Code/ocaml-playground/lazy-test.ml"
  1: "foo"
  2: "bar"
  3: "whatever"
  ```

  Now if you instead redirect stderr to stdout...

  ```bash
  ./lazy-test.ml foo bar whatever 2>&1
  ```

  ... you will see the actual steps that are being executed, in the order they are executed.

  ```
  `output` has been calculated; it should be a lazy `Seq`.
  Quoting /var/home/phil/Code/ocaml-playground/lazy-test.ml
  Numbering "/var/home/phil/Code/ocaml-playground/lazy-test.ml"
  0: "/var/home/phil/Code/ocaml-playground/lazy-test.ml"
  Quoting foo
  Numbering "foo"
  1: "foo"
  Quoting bar
  Numbering "bar"
  2: "bar"
  Quoting whatever
  Numbering "whatever"
  3: "whatever"
  ```
*)

let log_verbose = prerr_endline
let log_info = print_endline

let add_quotes str =
  let mapper x =
    "Quoting " ^ x |> log_verbose;
    "\"" ^ x ^ "\""
  in
  Seq.map mapper str

let add_indexes str =
  let mapper i x =
    "Numbering " ^ x |> log_verbose;
    Int.to_string i ^ ": " ^ x
  in
  Seq.mapi mapper str

let print_all seq = Seq.iter log_info seq

let () =
  let output = Sys.argv |> Array.to_seq |> add_quotes |> add_indexes in
  "`output` has been calculated; it should be a lazy `Seq`." |> log_verbose;
  output |> print_all
