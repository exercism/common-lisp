# Common Lisp

[![Configlet Lint Status](https://github.com/exercism/common-lisp/workflows/Configlet%20CI/badge.svg)](https://github.com/exercism/common-lisp/workflows/Configlet%20CI/badge.svg)
[![Config Check Status](https://github.com/exercism/common-lisp/workflows/Config%20Check/badge.svg)](https://github.com/exercism/common-lisp/workflows/Config%20Check/badge.svg)
[![Exercise Test Status](https://github.com/exercism/common-lisp/workflows/Test%20Exercises/badge.svg)](https://github.com/exercism/common-lisp/workflows/Test%20Exercises/badge.svg)

Exercism exercises in [Common Lisp][common-lisp].

## Contributing to the Common Lisp Track

There are several ways to contribute to the Common Lisp track including (but not limited to):

- Reporting problems with the track.
- Working on the [test runner][common-lisp-test-runner].
- Working on the [representer][common-lisp-representer].
- Working on the [analyzer][common-lisp-analyzer].
- Working on concept exercises.
- Working on practice exercises.
- Working on track documents.

There are two guides to the structure of the track and tooling which would be good to be familiar with.

* The [language track guide][language-track-guide]. 
This describes how all the language tracks are put together, as well
as details about the common metadata.

* The [track tooling guide][track-tooling-guide].
This describes the interface to the various tooling (test runner, representer and analyzer) as well as how they are used and invoked.

### Issues

Feel free to file an issues on the [track repository][track-issues] for problems of any size. 
Feel free to report typographical errors or poor wording for example.
You can greatly help improve the quality of the exercises by filing reports of invalid solutions that pass tests or of valid solutions that fail tests.

For issues specifically with [the analyzer][common-lisp-analyzer], [the representer][common-lisp-representer], or [the test runner][common-lisp-test-runner] please file the issues in the appropriate repository.

### Pull Requests

Feel free to submit [pull requests][track-pulls] to correct any [issues][track-issues] or to add new functionality.

For pull requests specifically with [the analyzer][common-lisp-analyzer], [the representer][common-lisp-representer], or [the test runner][common-lisp-test-runner] please file the pull requests in the appropriate repository.

Pull Requests should be focused on a single change.
They must pass the CI system before they will be merged.

### Creating or Modifying Exercises

There are two types of exercises: concept and practice.

Concept exercises are intended to teach the student a particular concept of the language.
They should be simple and short.
Refer to the document on the [anatomy of a concept exercises][concept-exercise] for details of the parts that are needed for a concept exercises.
The work needed for a concept exercise can be large, feel free to create an [issue][track-issues] or [pull request][track-pulls] to discuss ideas for a concept exercise so it can be worked on collaboratively.

Practice exercises are intended to allow a student to further practice and extend their knowledge of a concept.
They can be longer and/or more 'clever'.
Refer to the document on the [anatomy of a practice exercise][practice-exercise] for details of the parts that are needed for a concept exercise.
Many practice exercises are part of a canonical set of exercises shared across tracks (information on this can be found in the [problem specifications repository][problem-specs].
Before creating a new practice exercise please see if there is already a canonical problem defined there, if there is, this track will want to adhere to it rather than implementing something different.

## Development Setup

This track uses [SBCL][sbcl] for its development.
Since Common Lisp is a standardized language and (at present) exercises only use features and behavior specified by the standard any other conforming implementation could be used for development of features for the track. 
However any tooling created for this track (such as part of its build system) must work in [SBCL][sbcl]. 
It is outside the scope of this document to describe how to install a Common Lisp implementation. 
Please refer to the documentation for your chosen implementation for details.

The track also uses [QuickLisp][quicklisp] for system management.
Please refer to its documentation for instructions on how to install it.

### A note about QuickLisp & ASDF registries

The track contains some tools useful during development such as CI tasks.
These are provided as [ASDF][asdf] systems.
To ensure they are found appropriately by [QuickLisp][quicklisp] and [ASDF][asdf] either symbolic-link them into your `quickslip/local-projects` directory or by configuring your [ASDF registry][asdf-registry-config] appropriately.

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

[asdf-registry-config]: https://common-lisp.net/project/asdf/asdf/Configuring-ASDF-to-find-your-systems.html
[asdf]: https://common-lisp.net/project/asdf/
[common-lisp-analyzer]: https://github.com/exercism/common-lisp-analyzer
[common-lisp-representer]: https://github.com/exercism/common-lisp-representer.
[common-lisp-test-runner]: https://github.com/exercism/common-lisp-test-runner
[common-lisp]: https://common-lisp.net
[concept-exercise]: https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md
[language-track-guide]: https://github.com/exercism/docs/tree/main/building/tracks
[practice-exercise]: https://github.com/exercism/docs/blob/main/building/tracks/practice-exercises.md
[problem-specs]: https://github.com/exercism/problem-specifications/
[quicklisp]: https://www.quicklisp.org/beta/
[sbcl]: http://www.sbcl.org
[track-issues]: https://github.com/exercism/common-lisp/issues
[track-pulls]: https://github.com/exercism/common-lisp/pulls
[track-tooling-guide]: https://github.com/exercism/docs/tree/main/building/tooling
