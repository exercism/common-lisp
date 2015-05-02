Install a lisp implementation such as SBCL or CLisp. Both can be installed via Homebrew on Mac OS X.

```bash
brew install sbcl
# or
brew install clisp
```

Then install [QuickLisp](http://www.quicklisp.org/beta/#installation) and download [http://beta.quicklisp.org/quicklisp.lisp](http://beta.quicklisp.org/quicklisp.lisp).

```bash
curl -O http://beta.quicklisp.org/quicklisp.lisp
```

Load it into your running Lisp implementation, and type:

```lisp
(quicklisp-quickstart:install)
```

To add the startup code to your init file so that the next time you start the lisp interpreter QuickLisp will be loaded, type:

```lisp
(ql:add-to-init-file)
```

Optionally load lisp-unit:

```lisp
(ql:quickload "lisp-unit")
```

This will be done the first time you run any exercises tests. But you can do it now if you want.
