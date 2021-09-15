# Introduction

Common Lisp uses the standard arithmetic operators for most operations but is somewhat unique in using a "prefix-notation" as  opposed to the more familiar "infix-notion".

More visually:

```lisp
;; Infix-notation (non-lisp languages)
1 + 2 + 3 + 4 + 5 ; => 15
;; Prefix-notation (lisp languages)
(+ 1 2 3 4 5)     ; => 15
```

While prefix notion turns some operations like `2 + 2` into the somewhat unfamiliar `(+ 2 2)` form, it makes it much easier to operate on more than one number at a time.

## Basic Math

Common Lisp has all the typical functions: `+`, `-`, `*`, `/` for addition, subtraction, multiplication and division.

When considering division one may want to know the remainder of a division, that is done by the `mod` (for modulo) function which takes a number and a divisor as arguments: 

```lisp
(mod 4 2)  ; => 0
(mod 2 4)  ; => 2
(mod 10 3) ; => 1
```

## Comparing Numbers

Finally, you may find it useful to compare different numbers using functions like `=` (equal), `/=` (not equal to), and `>=` (greater than or equal to).
When these comparisons are true (as in `(= 1 1)`), they return `T` and when they aren't (as in `(> 0 1)`), they return `NIL`.

