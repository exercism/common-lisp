# Grade School

Given students' names along with the grade that they are in, create a roster
for the school.

In the end, you should be able to:

- Add a student's name to the roster for a grade
  - "Add Jim to grade 2."
  - "OK."
- Get a list of all students enrolled in a grade
  - "Which students are in grade 2?"
  - "We've only got Jim just now."
- Get a sorted list of all students in all grades.  Grades should sort
  as 1, 2, 3, etc., and students within a grade should be sorted
  alphabetically by name.
  - "Who all is enrolled in school right now?"
  - "Grade 1: Anna, Barb, and Charlie. Grade 2: Alex, Peter, and Zoe.
    Grade 3…"

Note that all our students only have one name.  (It's a small town, what
do you want?)

## For bonus points

Did you get the tests passing and the code clean? If you want to, these
are some additional things you could try:

- If you're working in a language with mutable data structures and your
  implementation allows outside code to mutate the school's internal DB
  directly, see if you can prevent this. Feel free to introduce additional
  tests.

Then please share your thoughts in a comment on the submission. Did this
experiment make the code better? Worse? Did you learn anything from it?

## Setup

Check out [Installing Common
Lisp](https://exercism.io/tracks/common-lisp/installation) for
instructions to get started or take a look at the guides available in
the [track's side bar](https://exercism.io/my/tracks/common-lisp).

## Formatting

While Common Lisp doesn't care about indentation and layout of code,
nor whether you use spaces or tabs, this is an important consideration
for submissions to exercism.io. Excercism.io's code widget cannot
handle mixing of tab and space characters well so using only spaces is recommended to make
the code more readable to the human reviewers. Please review your
editors settings on how to accomplish this. Below are instructions for
popular editors for Common Lisp.

### VIM

Use the following commands to ensure VIM uses only spaces for
indentation:

```vimscript
:set tabstop=2
:set shiftwidth=2
:set expandtab
```

(or as a oneliner `:set tabstop=2 shiftwidth=2 expandtab`). This can
be added to your `~/.vimrc` file to use it all the time.

### Emacs

Emacs is very well suited for editing Common Lisp and has many
powerful add-on packages available. The only thing that one needs to
do with a stock emacs to make it work well with exercism.io is to
evaluate the following code:

`(setq-default indent-tabs-mode nil)`

This can be placed in your `~/.emacs` (or `~/.emacs.d/init.el`) in
order to have it set whenever Emacs is launched.

One suggested add-on for Emacs and Common Lisp is
[SLIME](https://github.com/slime/slime) which offers tight integration
with the REPL; making iterative coding and testing very easy.

## Source

A pairing session with Phil Battos at gSchool [http://gschool.it](http://gschool.it)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
