Install a lisp implementation such as [SBCL](http://www.sbcl.org/)
or [CLisp](http://clisp.org/). Both can be installed via Homebrew on
Mac OS X.

```bash
brew install sbcl
# or
brew install clisp
```

See their homepages for instructions for installing on other
platforms.

We will use [QuickLisp] for package management. To install QuickLisp, first download quicklisp.lisp: 

```bash
curl -O http://beta.quicklisp.org/quicklisp.lisp
```

Then load it into your running Lisp implementation, e.g. using ```(load "quicklisp.lisp")``` in clisp. To complete the installation type:

```lisp
(quicklisp-quickstart:install)
```

Read more details about installing QuickLisp [here](http://www.quicklisp.org/beta/#installation).

To add the startup code to your init file so that the next time you
start the lisp interpreter QuickLisp will be loaded, type:

```lisp
(ql:add-to-init-file)
```

Optionally load lisp-unit:

```lisp
(ql:quickload "lisp-unit")
```

This will be done the first time you run any exercises tests. But you
can do it now if you want.
