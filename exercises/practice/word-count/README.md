# Word Count

Given a phrase, count the occurrences of each _word_ in that phrase.

For the purposes of this exercise you can expect that a _word_ will always be one of:

1. A _number_ composed of one or more ASCII digits (ie "0" or "1234") OR
2. A _simple word_ composed of one or more ASCII letters (ie "a" or "they") OR
3. A _contraction_ of two _simple words_ joined by a single apostrophe (ie "it's" or "they're")

When counting words you can assume the following rules:

1. The count is _case insensitive_ (ie "You", "you", and "YOU" are 3 uses of the same word)
2. The count is _unordered_; the tests will ignore how words and counts are ordered
3. Other than the apostrophe in a _contraction_ all forms of _punctuation_ are ignored
4. The words can be separated by _any_ form of whitespace (ie "\t", "\n", " ")

For example, for the phrase `"That's the password: 'PASSWORD 123'!", cried the Special Agent.\nSo I fled.` the count would be:

```text
that's: 1
the: 2
password: 2
123: 1
cried: 1
special: 1
agent: 1
so: 1
i: 1
fled: 1
```

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

This is a classic toy problem, but we were reminded of it by seeing it in the Go Tour.

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
