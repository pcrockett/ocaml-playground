Demonstrates how to use Seq for lazy evaluation.

This script uses stderr for verbose output. It's easier to understand if you first run it discarding the verbose output:

```sh
$ ./lazy-seq.ml a b c 2> /dev/null
0: "a"
1: "b"
2: "c"
```

Now if you instead redirect stderr to stdout, you will see the actual steps that are being executed, in the order they
are executed.

```sh
$ ./lazy-seq.ml a b c 2>&1
VERBOSE: `output` has been calculated; it should be a lazy `Seq`.
VERBOSE: Quoting a
VERBOSE: Numbering "a"
0: "a"
VERBOSE: Quoting b
VERBOSE: Numbering "b"
1: "b"
VERBOSE: Quoting c
VERBOSE: Numbering "c"
2: "c"
VERBOSE: Done evaluating `output`
```

