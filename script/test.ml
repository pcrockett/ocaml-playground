#!/usr/bin/env ocaml

let log_info = print_endline

type test_result = Pass of string | Fail of string

let run_tests file_path : test_result =
  let root_dir = Filename.dirname file_path in
  match
    Filename.quote_command "ocaml-mdx"
      [ "test"; "--verbose"; "--root"; root_dir; file_path ]
    |> Sys.command
  with
  | 0 -> (
      match Sys.file_exists (file_path ^ ".corrected") with
      | true -> Fail file_path
      | false -> Pass file_path)
  | _ -> Fail file_path

let handle_result result =
  (match result with
  | Pass file_path -> Filename.basename file_path ^ ": OK"
  | Fail file_path -> Filename.basename file_path ^ ": FAIL")
  |> log_info;
  result

let all_test_files root_dir =
  Sys.readdir root_dir |> Array.to_seq
  |> Seq.filter (String.ends_with ~suffix:".ml.md")
  |> Seq.map (fun file_name -> root_dir ^ Filename.dir_sep ^ file_name)

let is_failure result = match result with Fail _ -> true | _ -> false

let root_dir args =
  match args with
  | [| _ |] -> "."
  | [| _; dir_path |] -> dir_path
  | _ -> raise (Invalid_argument "Expecting 1 argument: test directory path")

let to_list seq = Seq.fold_left (fun a b -> a @ [ b ]) [] seq

let main args =
  match
    args |> root_dir |> all_test_files |> Seq.map run_tests
    |> Seq.map handle_result |> Seq.filter is_failure |> to_list
  with
  | [] -> 0
  | _ -> 1

let () = Sys.argv |> main |> exit
