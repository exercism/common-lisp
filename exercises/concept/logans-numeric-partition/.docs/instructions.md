# Instructions

Logan the Lisp alien likes numbers and also like organizing.

They ask you to help them write a function that will take a list of numbers and produce a pair of two lists - the first is all the odd numbers, the second are all the event numbers.

## 1. Categorizing a number

First you'll need to create a function which takes a pair of two lists and a number and put that number into the correct sub-list depending on if it is odd or even:

```lisp
(categorize-number '((1) . (2)) 23) ; => ((23 1) . (2))
(categorize-number '((1) . (2)) 42) ; => ((1) . (42 2))
```

## 2. Categorizing lots of numbers

Now that function you can write a function which takes a list of numbers and categorizes them like you did above:

```lisp
(partition-numbers '(1 2 3 4))     ; => ((3 1) . (4 2))
(partition-numbers '(42 31 24 13)) ; => ((13 31) . (24 42))
```

