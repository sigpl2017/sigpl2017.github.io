---
layout: post
title:  "Installing Coq on your Laptop"
date:   2017-02-06 23:59:34 +0900
categories: jekyll update
---

### Coq

- Use Coq [8.5pl2](https://coq.inria.fr).  *DO NOT* use other versions.
    + If not, your submissions (assignments & exams) will not be properly graded.

- Install Coq.
    + Installer (OS X / Windows)
        * Download [Binaries](https://coq.inria.fr/download) and install it.

    + OPAM (Linux / OS X)
        * Install necessary libraries.
            - OS X

                    # install brew (http://brew.sh/index.html)
                    brew install gtksourceview libxml2

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
    + Vim: [Coquille](https://github.com/the-lambda-church/coquille). See the troubleshootings below.

#Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

