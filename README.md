In this assignment, you will set up OCaml and compile & run a small
project. There are two options for installing OCaml covered here:

- Using it on the lab computers (much simpler)
- Installing it on your computer (takes a bit more but you can use your favorite
  text editor, etc. easily)


# Setting up OCaml on the lab computers

OCaml is already installed on the lab computers. You only need to add these two
lines to the `.bash_profile` file on your home directory (or `.zshrc` if you use
zsh, if you are not sure you are not using zsh, you are probably using bash on
Linux and zsh on Mac. To be sure, you can run `echo $ZSH_NAME`, it prints `zsh`
on zsh, and an empty line on bash):

```
export OPAMROOT=/usr/local/opam
eval $(opam env)
```

You can use whatever text editor is available to you in the lab to do
this. After you do this, log in again to the lab computer, then you should see
something like the following when you run `utop`:

```
────────┬──────────────────────────────────────────────────────────────┬────────
        │ Welcome to utop version 2.10.0 (using OCaml version 4.14.0)! │
        └──────────────────────────────────────────────────────────────┘

Type #utop_help for help about using utop.

─( 03:44:27 )─< command 0 >──────────────────────────────────────{ counter: 0 }─
utop #
┌───┬─────┬───────────┬──────────────┬──────┬────────┬────┬──────┬─────┬───────┐
│Arg│Array│ArrayLabels│Assert_failure│Atomic│Bigarray│Bool│Buffer│Bytes│BytesLa│
└───┴─────┴───────────┴──────────────┴──────┴────────┴────┴──────┴─────┴───────┘
```

Contact me if you are having trouble with this step. If everything worked out so
far, please go to the section _"Testing if `dune` works"_.

# Installing OCaml on your computer

First, you need to install `opam` (OCaml package manager), which allows you to
install OCaml-related tools. Then, you will install a specific version of OCaml
and the pacakages we use so that we all use the same version of the language.

### A note if you are using Windows

I recommend using Linux (or Mac as a workable substitute) for OCaml because the
OPAM's support for Windows is not great. If you are using Windows, use Windows
Subsystem for Linux (WSL). If you are not sure how to use it, contact me.

## Installing `opam`

Please follow the instructions [here](https://opam.ocaml.org/doc/Install.html)
on how to install `opam` for your OS.

- If you are using WSL, then you can follow the instructions for Ubuntu or the
  binary distribution.
- If you have a Mac, installing it via Homebrew would be the most
  straight-forward way if you have it. Otherwise, the binary distribution method
  should be straightforward.

## Installing OCaml

**Use the commands below one-by-one, read the instructions on the screen and
proceed accordingly, some students just pasted everything all in one go, which
does not work. Some of the commands below are interactive.**

In this step, you are going to install a specific version of OCaml using `opam`.

After installing `opam`, you need to first tell your shell where the stuff
`opam` installs lives. Use the following command to initialize an environment:

```
opam init
```

The command above will ask you a yes-no question, you should answer yes,
otherwise you will need to type the next command every single time (as opposed
to only once) to tell your shell where the OCaml stuff is.

After `opam init` is done, type the following command so you can have the OCaml
tools in your current shell session:

```
eval $(opam env)
```

Now, you are ready to install OCaml. Use the following command to install a
version of OCaml (called a switch by `opam`):

```
opam switch create 4.14.0
```

After the command above is done, you need to tell your shell where OCaml is
again:

```
eval $(opam env)
```

At this point, if everything went well, when you type `ocaml`, you should see a
prompt like this when you type `ocaml`:

```
% ocaml
        OCaml version 4.14.0

#
```

Then, you can proceed to the next stage, installing `utop`:

## How to install `utop`

[`utop`](https://opam.ocaml.org/blog/about-utop/) is an enhanced OCaml
interpreter with features like autocompletion. If you have `opam` installed (see
above), you can install `utop` using

```
opam install utop
```

Then `utop` should be available as a command.

## Loading a file in `utop`

When you want to load a file in `utop` so that you can run the functions inside,
use the `#use "file name"` directive. For example, if you create a file named
`example.ml` with the following contents:

```ocaml
let fact n = if n = 0 then 1 else n * fact (n - 1)
```

You'd type `#use "example.ml" ;;` on `utop` to load it, and use it to see that
the 6! = 720 (the `utop# ` part is the prompt, you wouldn't
type that):

```
─( 03:47:07 )─< command 0 >──────────────────────────────────────{ counter: 0 }─
utop # #use "example.ml";;
val fact : int -> int = <fun>
─( 03:47:07 )─< command 1 >──────────────────────────────────────{ counter: 0 }─
utop # fact 6;;
- : int = 720
```

## Installing `dune` and other packages we need

**Skip this step if you are using the lab machines.**

We will use `dune` to build our assignments (and manage their dependencies). It
is similar to Make if you have seen it in CS 215. Installing it is similar to
how we set things up before:

```bash
opam install dune linenoise alcotest
```

## Testing if `dune` works

After you installed `dune`, you can build the code in this repository with `dune
build`:

```
dune build
```

It shouldn't print any error messages if things go well. Then, you can run the
unit tests in `test.ml` which test the Fibonacci series implementation in `setup.ml`:

```
dune test
```

If all goes well, you should see something like the following:

```
Testing `setup'.
This run has ID `Z3Z4ZRHG'.

  [OK]          fib correctness          0   fib 1.
  [OK]          fib correctness          1   fib 2.
  [OK]          fib correctness          2   fib 3.
  [OK]          fib correctness          3   fib 4.
  [OK]          fib correctness          4   fib 5.
  [OK]          fib correctness          5   fib 6.
  [OK]          fib correctness          6   fib 7.
  [OK]          fib correctness          7   fib 8.
  [OK]          fib correctness          8   fib 30.

Full test results in `~/lab/ocaml-setup/_build/default/_build/_tests/setup'.
Test Successful in 0.002s. 9 tests run.
```

If you run `dune build` or `dune test` without changing the files, dune will
not print anything (if everything compiled and passed all tests): dune checks
if any files are changed, and runs & builds only what has changed.

Finally, you should be able to run the REPL in this repo (it is in `frepl.ml`
and computes fib(n) for a given n). To run it, we will use `dune exec` which
runs an executable (after building it if needed):

```
dune exec -- ./frepl.exe
```

Now you should see a prompt like the following that you can interact with.

```
Welcome to frepl, your friendly neighborhood Fibonacci repl!
>
```

Here is an interaction with the repl (the lines starting with `> ` is
frepl waiting for your input):

```
Welcome to frepl, your friendly neighborhood Fibonacci repl!
> 1
fib 1 = 1
> 3
fib 3 = 2
> 5
fib 5 = 5
> 12
fib 12 = 144
```

### Using `dune` and `utop` together

**This information will pay off well in the course later on.**

Finally, if you want to use `utop` with the definitions in the current project,
you can use `dune utop`, then you don't need to load a file with `#use`.  This
is especially useful when we have projects with multiple modules later in class.

Here is an example session where we open the `Setup` module (which is defined in
`setup.ml`) and run the `fib` function with some arguments:

```
────────┬──────────────────────────────────────────────────────────────┬────────
        │ Welcome to utop version 2.10.0 (using OCaml version 4.14.0)! │
        └──────────────────────────────────────────────────────────────┘

Type #utop_help for help about using utop.

─( 04:57:54 )─< command 0 >──────────────────────────────────────{ counter: 0 }─
utop # open Setup ;;
─( 04:57:54 )─< command 1 >──────────────────────────────────────{ counter: 0 }─
utop # fib 1 ;;
- : int = 1
─( 04:57:57 )─< command 2 >──────────────────────────────────────{ counter: 0 }─
utop # fib 6 ;;
- : int = 8
```
