# xLisp

[![Build Status](https://travis-ci.org/exercism/xlisp.svg)](https://travis-ci.org/exercism/xlisp)

Exercism exercises in Lisp


## Contributing To the Common Lisp Track

### Contributing Guide

Please be familiar with the
[contributing guide](https://github.com/exercism/x-api/blob/master/CONTRIBUTING.md#the-exercise-data)
in the x-api repository. This describes how all the language tracks
are put together, as well as details about the common metadata, and
high-level information about contributing to existing problems and
adding new problems.

### Issues

Feel free to file any issues at
https://github.com/exercism/xlisp/issues for problems of any size.
Feel free to report typographical errors or poor wording for example.
You can greatly help improve the quality of the exercises by filing
reports of invalid solutions that pass tests or of valid solutions
that fail tests

### Development setup

Direct contributions to the Common Lisp code in xLisp are always welcome.
Refer to [the Getting Started Guide](http://exercism.io/languages/lisp) for the
Common Lisp track to get your environment set up if needed.

New exercises or changes to existing ones can be submitted via a pull
request. You will need a GitHub account and you will need to fork
`exercism/xlisp` to your account. See
[GitHub Help](https://help.github.com/articles/fork-a-repo/) if you
are unfamiliar with the process.

A list of exercises yet to be created is in
[issue #23](https://github.com/exercism/xlisp/issues/23). This might
be a great place to get started.

#### Development Guidelines

##### Setting up the development environment.

All changes will be built under several implementations via the
[TravisCI build](https://travis-ci.org/exercism/xlisp) so it advisable
to be able to run at least some of those same builds locally before
submitting the changes.

A contributor will need to install
[CIM](https://github.com/KeenS/CIM),
[QuickLisp](https://www.quicklisp.org/beta/), and a few Lisp
implementations.

###### CIM

Instructions for installing CIM can be found in its
[README](https://github.com/KeenS/CIM#install). The simplest form is:

```
curl -L https://raw.github.com/KeenS/CIM/master/scripts/cim_installer | /bin/sh
cim config sh >> ~/.bashrc
```

Note: the xLisp team does not currently advise using CIM for
installing implementations. While it works well as a
multi-implementation runner, it is not currently sufficient as a
multi-implementation installation and upgrade system.

###### Lisp Implementations

It is beyond the scope of this document to describe how to install
different Lisp implementations. Please find those instructions on
those implementations' websites.

After installing Lisp implementations. Check that CIM can see them by
running `cim list use`. This should list the implementation names
suffixed with `-system` (designating that CIM did not install them).
Then to ensure CIM can use them properly run:

```
for i in `cim list use`; do cim use $i; done
```

###### QuickLisp

Instructions to install QuickLisp can be found on this
[website](https://www.quicklisp.org/beta/#installation). Following
these instructions will install the QuickLisp system into
`~/.quicklisp`.

To ensure CIM and all your implementations know and use QuickLisp you
can run the following commands:

```
ln ~/quicklisp ~/.cim/quicklisp
cim for all do -l ~/.quicklisp/setup.lisp -e '(ql:add-to-init-file)'
```

(the last command will, for each implementation, install QuickLisp
setup code into that implementation's startup file. It will prompt the
user for confirmation before doing so.

##### Creating a new exercise.

All new exercise submissions should contain not only the test file,
but the stub of the "production code" (containing the `defpackage` and
`in-package` forms), and a file `example.lisp` which contains an
example implementation. The "production code" and `example.lisp` may
also include an empty function declaration for the functions under
test.

##### Building & Testing

Before submitting a new exercise please ensure that it passes the
Travis build.  This build will run all exercises on many Common Lisp
implementations. To run the build yourself on your implementation load
`bin/xlisp-test.lisp` and then evaluate `(xlisp-test:full-build)`.

If CIM is installed then running all the tests for one implementation
can be done with (this will return with a non-zero error code if there
are problems):

	cl -f bin/xlisp-test.lisp -e '(xlisp-test:travis-build)'

To run all the tests for *all* the implementations use this command
line:

	cim for all do -f bin/xlisp-test.lisp -e '(xlisp-test:travis-build)'

##### Style Guidelines

The example implementation should use nothing outside of the Common
Lisp specification. It should be well designed and not too clever.
(Save the clever implementation for your submission on Exercism.io.)

## License

The MIT License (MIT)

Copyright (c) 2014 Katrina Owen, _@kytrinyx.com
