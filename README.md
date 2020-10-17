# Common Lisp 

[![Configlet Lint Status](https://github.com/exercism/common-lisp/workflows/configlet-lint/badge.svg)](https://github.com/exercism/common-lisp/workflows/configlet-lint/badge.svg)
[![Exercise Test Status](https://github.com/exercism/common-lisp/workflows/exercise-tests/badge.svg)](https://github.com/exercism/common-lisp/workflows/exercise-tests/badge.svg)

Exercism exercises in Lisp

## Contributing to the Common Lisp Track

### Contributing Guide

Please be familiar with the [language track contributing
guide](https://github.com/exercism/docs/blob/master/contributing-to-language-tracks/README.md)
. This describes how all the language tracks are put together, as well
as details about the common metadata, and high-level information about
contributing to existing problems and adding new problems.

### Issues

Feel free to file an issues on the [track
 repository](https://github.com/exercism/common-lisp/issues) for
 problems of any size. Feel free to report typographical errors or
 poor wording for example. You can greatly help improve the quality of
 the exercises by filing reports of invalid solutions that pass tests
 or of valid solutions that fail tests

### Development setup

Direct contributions to the Common Lisp code in this track are always
welcome. Refer to [Installing Common Lisp
guide](http://exercism.io/languages/common-lisp/installation) to get
your environment set up if needed.

New exercises or changes to existing ones can be submitted via a pull
request. You will need a GitHub account and you will need to fork
`exercism/common-lisp` to your account. See
[GitHub Help](https://help.github.com/articles/fork-a-repo/) if you
are unfamiliar with the process.

#### Development Guidelines

##### Setting up the development environment.

All changes will be built under several implementations via the
[TravisCI build](https://travis-ci.org/exercism/common-lisp) so it advisable
to be able to run at least some of those same builds locally before
submitting the changes.

A contributor will need to install:

* [Roswell](https://github.com/roswell/roswell)
* [QuickLisp](https://www.quicklisp.org/beta/)
* and a few Lisp implementations.


###### Roswell

Instructions for installing Roswell can be found in
its
[README](https://github.com/roswell/roswell#installation-dependency--usage).

###### Lisp Implementations

It is beyond the scope of this document to describe how to install
different Lisp implementations. Please find those instructions on
those implementations' websites.

After installing Lisp implementations. Check that Roswell can see them by
running `ros list installed`.

###### QuickLisp

Although [QuickLisp](https://www.quicklisp.org/beta/) is
required, Roswell will install and configure it for you, by default.

#### Creating a new exercise.

There are many exercises for Exercism. This track does not yet
implement all of them for Common Lisp. Please see the info about all
exercises in the
[`problem-specifications`](https://github.com/exercism/problem-specifications)
repository. To create a good submission for a new exercise you will
need to have cloned the above repository and ensure it is up to date.

0. Choose the exercise you'd like to create from the
   [`problem-specifications`](https://github.com/exercism/problem-specifications)
   repository.
1. Create an exercise sub-directory for your exercise: `mkdir
   exercises/<your-exercise>`.
2. Use `./bin/configlet` to get the `README`: `./bin/configlet
   generate . --only <your-exercise> --spec-path
   <path-to-problem-specifications>`.
3. Using the canonical data found in the `problems-specifications`
   repository create tests for the exercise. A template for the test
   file can be found in
   [`docs/template-test.lisp`](docs/template-test.lisp) (change
   `exercise` to the name of your exercise in kebab-case).
4. Create an example implementation which passes the tests. This does
   not need to be clever or amazing (save that for your own solution
   submission), but it should have good style and idiom and use
   nothing outside of the Common Lisp specification.
5. Create a stub "production file" for the mentee to start with. A
   template for this file can be found in
   [`/template-production.lisp`](docs/template-production.lisp). 
6. Add your exercise to `config.json` and use `./bin/configlet` to
   ensure that it is well formatted: `./bin/configlet fmt .`.
7. Create a PR.

##### Experimental Exercise Generation

Load the `generate-exercise` ASDF system (found in `src`) and then
call the function `generate-exercise:generate` with the name the
exercise in problem specifications repository you'd like to stub out.
Also provide the path to the problems specifications repository and
the `exericses` directory to put the new exercise into.

Alternatively use the `generate-exercise/executable` ASDF system to
create the standalone executable `bin/generate-exercise` which can do
the same (use `bin/generate-exercise -h` to see the usage info).

##### Building & Testing

Before submitting a new exercise please ensure that it passes the
Travis build. This build will run all exercises on many Common Lisp
implementations. To run the build yourself on your implementation load
`src/xlisp-test/xlisp-test.lisp` and then evaluate
`(xlisp-test:full-build)`. The same can be done by calling `asdf:make`
on the `"xlisp-test/test"` system (ASDF system definition file is
`src/xlisp-test.asd`).

If Roswell is installed then running all the tests for one
implementation can be done with (this will return with a non-zero
error code if there are problems):

    ros run -l 'src/xlisp-test/xlisp-test.lisp' -e '(xlisp-test:travis-build)' -q
