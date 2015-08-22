# xLisp

Exercism exercises in Lisp

[![Build Status](https://travis-ci.org/exercism/xlisp.png?branch=master)](https://travis-ci.org/exercism/xlisp)

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

Direct contributions to the Common Lisp code in xlisp are always
welcome. 
Refer to
[the Getting Started Guide](http://help.exercism.io/getting-started-with-lisp.html)
for the Common Lisp track to get your environment set up if needed.

New exercises or changes to existing ones can be submitted via a pull
request. You will need a GitHub account and you will need to fork
exercism/xlisp to your account. See
[GitHub Help](https://help.github.com/articles/fork-a-repo/) if you
are unfamiliar with the process.

A list of exercises yet to be created is in
[issue #23](https://github.com/exercism/xlisp/issues/23). This might
be a great place to get started.

#### Development Guidelines

##### Creating a new exercise.

All new exercise submissions should contain not only the test file,
but the stub of the "production code" (containing the `defpackage` and
`in-package` forms), and a file `example.lisp` which contains an
example implementation.

##### Building & Testing

Before submitting a new exercise please ensure that it passes the
Travis build.  This build will run all exercises on many Common Lisp
implementations. To run the build yourself on your implementation load
`bin/xlisp-test.lisp` and then evaluate `(xlisp-test:test-exercises)`.

[CIM](https://github.com/KeenS/CIM) is a tool for working with several
Common Lisp implementations at the same time. Allowing for easy
switching between them and for consistent usage of them from the
command line. It is recommended that one installs CIM and several
implementations.

If CIM is installed then running all the tests for one implementation
can be done with: 

	cl -f bin/xlisp-test.lisp -e '(when (xlisp-test:test-exercises) (uiop:quit 4))'

To run all the tests for *all* the implementations use this command
line:

	cim for all do -f bin/xlisp-test.lisp -e '(when (xlisp-test:test-exercises) (uiop:quit 4))'

##### Style Guidelines

The example implementation should use nothing outside of the Common
Lisp specification. It should be well designed and not too clever.
(Save the clever implementation for your submission on Exercism.io.)

## License

The MIT License (MIT)

Copyright (c) 2014 Katrina Owen, _@kytrinyx.com
