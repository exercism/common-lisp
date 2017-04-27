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

We will use [QuickLisp](http://www.quicklisp.org/beta/#installation) for Lisp library management. To install QuickLisp: 

```bash
curl -O http://beta.quicklisp.org/quicklisp.lisp
```

Now launch your lisp implementation, and copy-paste the following expressions to finish QuickLisp installtion:

```lisp
> (quicklisp-quickstart:install)  ;; this will install quicklisp
> (ql:add-to-init-file)           ;; this will add quicklisp setup to your init file (recommended)
```

See the documentation of your lisp implementation on how to load quicklisp.lisp into your running lisp environment.

Optionally load lisp-unit:

```lisp
(ql:quickload "lisp-unit")
```

This will be done the first time you run any exercises tests. But you
can do it now if you want.
