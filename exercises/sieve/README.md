# Sieve

Use the Sieve of Eratosthenes to find all the primes from 2 up to a given
number.

The Sieve of Eratosthenes is a simple, ancient algorithm for finding all
prime numbers up to any given limit. It does so by iteratively marking as
composite (i.e. not prime) the multiples of each prime, starting with the
multiples of 2. It does not use any division or remainder operation.

Create your range, starting at two and continuing up to and including the given limit. (i.e. [2, limit])

The algorithm consists of repeating the following over and over:

- take the next available unmarked number in your list (it is prime)
- mark all the multiples of that number (they are not prime)

Repeat until you have processed each number in your range.

When the algorithm terminates, all the numbers in the list that have not
been marked are prime.

The wikipedia article has a useful graphic that explains the algorithm:
https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes

Notice that this is a very specific algorithm, and the tests don't check
that you've implemented the algorithm, only that you've come up with the
correct list of primes. A good first test is to check that you do not use
division or remainder operations (div, /, mod or % depending on the
language).

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

Sieve of Eratosthenes at Wikipedia [http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes](http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
