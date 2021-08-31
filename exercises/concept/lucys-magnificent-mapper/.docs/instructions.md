# Instructions

Lucy the Lisp Alien likes Numbers, they think some of the are "magnificent".

They ask you to help them write functions to make numbers more magnificent.

What Lucy thinks makes a number magnificent can change so the functions will need to be flexible.

## 1. Make magnificent

To make a list of numbers into a list of more magnificent numbers you'll need to write a function `make-magnificent-maybe` which takes a function to apply to the numbers and a list of numbers.
It should evaluate to a list of numbers which are more magnificent (according to the function provided)

```lisp
(make-magnificent-maybe #'square '(1 2 3)) ; => (1 4 9)
(make-magnificent-maybe #'1+ '(1 2 3))     ; => (2 3 4)
```

## 2. Only the best

After (hopefully) making numbers more magnificent, Lucy wants to just see the numbers which are truly magnificent.

They definitely know that 1 is *never* magnificent so you'll need to just remove that.

But other than that Lucy changes their mind sometimes so again they'll give you a function which will tell you if a number is magnificent or not.

You'll need to write a function `only-the-best` which takes a function and a list of numbers and returns only the best numbers (not `1` and not numbers that the function evaluates to true for).


```lisp
(only-the-best #'evenp '(1 2 3 4 5)) ; => (3 5)
(only-the-best #'oddp '(1 3 5))    ; => ()
```


