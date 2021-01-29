# Meetup

Calculate the date of meetups.

Typically meetups happen on the same day of the week.  In this exercise, you
will take a description of a meetup date, and return the actual meetup date.

Examples of general descriptions are:

- The first Monday of January 2017
- The third Tuesday of January 2017
- The wednesteenth of January 2017
- The last Thursday of January 2017

The descriptors you are expected to parse are:
first, second, third, fourth, fifth, last, monteenth, tuesteenth, wednesteenth,
thursteenth, friteenth, saturteenth, sunteenth

Note that "monteenth", "tuesteenth", etc are all made up words. There was a
meetup whose members realized that there are exactly 7 numbered days in a month
that end in '-teenth'. Therefore, one is guaranteed that each day of the week
(Monday, Tuesday, ...) will have exactly one date that is named with '-teenth'
in every month.

Given examples of a meetup dates, each containing a month, day, year, and
descriptor calculate the date of the actual meetup.  For example, if given
"The first Monday of January 2017", the correct meetup date is 2017/1/2.

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

Jeremy Hinegardner mentioned a Boulder meetup that happens on the Wednesteenth of every month [https://twitter.com/copiousfreetime](https://twitter.com/copiousfreetime)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
