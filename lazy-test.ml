#!/usr/bin/env ocaml

let add_quotes cli_args = Seq.map (fun x -> "\"" ^ x ^ "\"") cli_args
let print_all seq = Seq.iter (fun x -> print_endline x) seq
let () = Sys.argv |> Array.to_seq |> add_quotes |> print_all
