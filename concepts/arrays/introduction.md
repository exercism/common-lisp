# Introduction

In Common Lisp like other languages an array is a set of elements which are accessed via integral indexes.
The types of the elements can be heterogeneous.
The array can be multi-dimensional (not simply 1-dimensional).

## Creating

`make-array` allows one to create arrays.
It has many options but its simpler forms allow one to create N-dimensional arrays with all elements initialized to a single value or the array initialized to the values in another sequence (such as a list). 
Its first argument is a list of the size of each dimension.

```lisp
(make-array '(4) :initial-element 3)    ; => #(3 3 3 3)
(make-array '(2 2) :initial-element 'x) ; => #2A((X X) (X X))
```

(Notice how the N-dimensional arrays are printed with the number of dimensions.)

Arrays can also be created by using the same format they are printed in: 

```lisp
#(x y z)         ; => #(X Y Z)
#2A((1 2) (3 4)) ; => #2A((1 2) (3 4))
```

## Accessing Elements

To access elements of a vector use `aref`, the indexes are zero-based. 
The number of indexes provided must match the rank of the array.

```lisp
(aref #2A((1 2 3) (3 4 5)) 
       1 0)           ; => 3
(aref #3A(((a b) (c d)) 
           ((e f) (g h)) 
           ((t u) (v w))) 
       2 0 1)         ; => U
(aref #2A((1) (2)) 0) ; => ERROR (because not enough indexes provided)
```

