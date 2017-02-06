---
layout: post
title:  "Installing Coq on your Laptop"
date:   2017-02-06 23:59:34 +0900
categories: jekyll update
---

### Coq

- Install Coq8.5pl2.
    + Installer (OS X / Windows)
        * Win64 [Binary](https://coq.inria.fr/distrib/8.5pl2/files/coq-installer-8.5pl2-win64.exe)
        * OS X [Binary](https://coq.inria.fr/distrib/8.5pl2/files/CoqIDE_8.5pl2.dmg)

    + OPAM (Linux)
        * Install necessary libraries.

            - CentOS-like Linux

                    sudo yum install gtksourceview2-devel

            - Debian-like Linux

                    sudo apt-get install liblablgtksourceview2-ocaml-dev

        * Install [opam](http://opam.ocaml.org/doc/Install.html), and make sure you can use OCaml 4.03.0.
        * `opam init --comp 4.03.0`
        * `opam install coqide.8.5.2`
        * Test by `coqc -v` in the command line. Check your `PATH` variable if you get an error.
        * Run CoqIDE by `coqide`.

- Use IDEs supporting Coq.
    + CoqIDE: installed by default. (Recommended)
    + Emacs: [Company-Coq](https://github.com/cpitclaudel/company-coq). Follow the setup instructions.
    + Vim: [Coquille](https://github.com/the-lambda-church/coquille).


### Troubleshootings

- If you use Coquille (on Vim) and your terminal is hidden by some message (`warning (some rule has been masked)`), please edit `~/.vim/.../coquille/autoload/coquille.py`'s `restart_coq` as follows (NOTE: `stderr = subprocess.PIPE`):

        def restart_coq(*args):
        global coqtop
        if coqtop: kill_coqtop()
        try:
            coqtop = subprocess.Popen(
                    ["coqtop", "-ideslave"] + list(args),
                    stdin = subprocess.PIPE,
                    stdout = subprocess.PIPE,
                    stderr = subprocess.PIPE,
                    preexec_fn = ignore_sigint
                    )
        except OSError:
            print("Error: couldn't launch coqtop")

