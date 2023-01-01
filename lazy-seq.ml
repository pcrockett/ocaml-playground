#!/usr/bin/env ocaml

let log_verbose msg = "VERBOSE: " ^ msg |> prerr_endline
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
  (*
    I'd normally write the program like this...

    Sys.argv |> Array.to_seq |> Seq.drop 1 |> add_quotes |> add_indexes |> print_all

    ... however I'm splitting this up to demonstrate a point.
  *)
  let output =
    Sys.argv |> Array.to_seq |> Seq.drop 1 |> add_quotes |> add_indexes
  in
  "`output` has been calculated; it should be a lazy `Seq`." |> log_verbose;
  output |> print_all;
  "Done evaluating `output`" |> log_verbose
