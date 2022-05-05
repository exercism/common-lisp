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

#### Practice Exercise Generation

Many practice exercises are part of a canonical set of exercises shared across tracks (information on this can be found in the [problem specifications repository][problem-specs].
There is a generator in the ./bin folder that you can use to generate all of the requisite files from the problem-specifications.
(Note, you _will_ need to have cloned the [problem specifications repository][problem-specs] for the generator to work.)
You can run the executable directly by double-clicking on it and following the prompts, or you can run it from the command line.
If you wish to run the generator from the command line, first navigate to your common-lisp repository.
From here, there are two ways to run the generator, the first way being to enter the following:

```sh
./bin/lisp_exercise_generator
```

and from there, follow the prompts.
The second way is to type in:

```sh
./bin/lisp_exercise_generator [-f] [path-to-prob-spec exercise author]
```

where:
- path-to-prob-spec is the relative or absolute path to your problem-specifications repository
- exercise is the name of the exercise to be generated
- author is your Github handle
- -f is a flag to force overwrite an existing exercise

Any one of these methods will generate and fill in all the necessary files, with the exception of the .meta/example.lisp file, which you will need to complete yourself.
**The common-lisp/config.json file will remain unaltered** - you will have to manually alter this file.

A Common Lisp replacement for this generator will be coming "soon".

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

### A note about markdown files

Some exercises have a `introduction.md.tpl` file - this means that exercise's `introduction.md` file is not meant to be edited by hand, instead it is generated by combining other documents. To update the `introduction.md` files one must run `./bin/configlet generate`.

## Track Build System

This track uses [GitHub Actions][github-actions] as a build system.

It contains several workflows:

* [`configlet.yml`][workflow-configlet] - runs [`configlet`][configlet] to do a general track structure check.
* [`config-checker.yml`][workflow-config-checker] - runs the [`config-checker` system][config-checker-system] to do some other specific track structure checks.
* [`test-exercises.yml`][workflow-text-exercises] - runs the [`test-execise` system][test-exercise-system] to run all exercise tests against the example/exemplar files to verify validity of the solutions.

### Building & Testing

To run the build "manually" execute the following from the root directory of the track:

* In the shell: `./bin/fetch-configlet && ./configlet lint`
* In the REPL: `(progn (asdf:load-system "config-checker") (config-checker:check-config))`
* In the REPL: `(asdf:test-system "test-exercises")`

[asdf-registry-config]: https://common-lisp.net/project/asdf/asdf/Configuring-ASDF-to-find-your-systems.html
[asdf]: https://common-lisp.net/project/asdf/
[common-lisp-analyzer]: https://github.com/exercism/common-lisp-analyzer
[common-lisp-representer]: https://github.com/exercism/common-lisp-representer
[common-lisp-test-runner]: https://github.com/exercism/common-lisp-test-runner
[common-lisp]: https://common-lisp.net
[concept-exercise]: https://github.com/exercism/docs/blob/main/building/tracks/concept-exercises.md
[config-checker-system]: https://github.com/exercism/common-lisp/blob/main/src/config-checker.asd
[configlet]: https://github.com/exercism/configlet
[github-actions]: https://github.com/features/actions
[language-track-guide]: https://github.com/exercism/docs/tree/main/building/tracks
[practice-exercise]: https://github.com/exercism/docs/blob/main/building/tracks/practice-exercises.md
[problem-specs]: https://github.com/exercism/problem-specifications/
[quicklisp]: https://www.quicklisp.org/beta/
[sbcl]: http://www.sbcl.org
[test-exercise-system]: https://github.com/exercism/common-lisp/blob/main/src/test-exercises.asd
[track-issues]: https://github.com/exercism/common-lisp/issues
[track-pulls]: https://github.com/exercism/common-lisp/pulls
[track-tooling-guide]: https://github.com/exercism/docs/tree/main/building/tooling
[workflow-config-checker]: https://github.com/exercism/common-lisp/blob/main/.github/workflows/config-checker.yml
[workflow-configlet]: https://github.com/exercism/common-lisp/blob/main/.github/workflows/configlet.yml
[workflow-text-exercises]: https://github.com/exercism/common-lisp/blob/main/.github/workflows/test-exercises.yml
