This script detects all "test" Markdown files and runs the tests in those files.

Rationale for this script:

* I like Cram tests, but I didn't want to use `dune` for this repository, which has built-in support for Cram tests.
* I _also_ didn't want to use the very automation-unfriendly `ocaml-mdx` command to run each individual test file.
* I _**also**_ didn't want to write a Bash script to do my automated test stuff (after all, this is an _OCaml_ playground).
* I _**ALSO**_ was looking for an excuse to write more OCaml.

Thus, the `test.ml` script was born.

Run all tests in the root of the repository:

```sh
$ ./test.ml ..
...
```

How the Makefile uses it:

```sh
$ cd .. && make test
./script/test.ml
...
```

Some errors you may encounter:

```sh
$ ./test.ml some/path invalid argument
Exception: Invalid_argument "Expecting 1 argument: test directory path".
[2]
$ ./test.ml this/path/does/not/exist
Exception: Sys_error "this/path/does/not/exist: No such file or directory".
[2]
```
