# About

In Common Lisp like other languages an array is a set of elements which are accessed via integral indexes.
The types of the elements can be heterogeneous.
The array can be multi-dimensional (not simply 1-dimensional).

## Creating

`make-array` allows one to create arrays.
It has many options but its simpler forms allow one to create N-dimensional arrays with all element initialized to a single value or the array initialized to the values in another sequence (such as a list). 
Its first argument is a list of the size of each dimension.

```lisp
(make-array '(4) :initial-element 3)    ; => #(3 3 3 3)
(make-array '(2 2) :initial-element 'x) ; => #2A((X X) (X X))
(make-array '(3 3 3) 
  :initial-contents '(((a b c) (d e f) (g h i)) 
                      ((j k l) (m n o) (p q r)) 
                      ((s t u) (v w x) (y z &))))
                                        ; => #3A(((A B C) (D E F) (G H I))
                                                 ((J K L) (M N O) (P Q R))
                                                 ((S T U) (V W X) (Y Z &)))
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
(aref #2A((1 2 3) (3 4 5)) 1 0) ; => 3
(aref #3A(((a b) (c d)) 
          ((e f) (g h)) 
          ((t u) (v w))) 
      2 0 1)                    ; => U
(aref #2A((1) (2)) 0)           ; => ERROR (because not enough indexes provided)
```

Also the indexes provided must be 'in bounds' given the dimensions provided when the array was created.
This can be checked with `array-in-bounds-p`:

```lisp
(array-in-bounds-p #2A((1) (2)) 0 1) ; => T
(array-in-bounds-p #2A((1) (2)) 2 0) ; => NIL
```

An element can also be accessed with `row-major-aref` which takes a single integer specifying the element in [row-major order][row-major-order].
(The row-major index can be computed from the indexes via `array-row-major-index`.)

```lisp
(array-row-major-index #2A((1 2 3) (4 5 6)) 1 1 ) ; => 4
(row-major-aref #2A((1 2 3) (4 5 6)) 4)           ; => 5
```

## Predicate

To deterine if an object is an array one can use `arrayp`.

```lisp
(arrayp #(1 2 3))            ; => T
(arrayp #2((1 2 3) (4 5 6))) ; => T
(arrayp (list 1 2 3))        ; => NIL
```

## Queries about Arrays

Various information about an array may be retrieved with the following functions:

* `array-rank` to get the number of dimensions of the array (referred to as the array's rank).
* `array-dimensions` to get a list of the sizes of the array's dimensions.
* `array-dimension` to get the size of one of the dimensions.
* `array-total-size` to get total number of elements in the array.

```lisp
(let ((array #3A(((0 1) (2 3) (4 5)) 
                 ((6 7) (8 9) (A B)) 
                 ((C D) (E F) (G H))
                 ((I J) (K L) (M N)))))
  (list (array-rank array)
        (array-dimensions array)
        (array-dimension array 1)
        (array-total-size array))) ; => (3 (4 3 2) 2 24)
```

## Limits on the Size of Arrays

The Common Lisp Standard defines some limits on the maximum size of arrays.
These limits are available in some defined constants: 

* `array-rank-limit`: the maximum allowed number of dimensions of an array (defined to be no smaller than 8).
* `array-dimension-limit`: the maximum size of any one dimension (defined to be no smaller than 1024).
* `array-total-size-limit`: the maximum number of elements of any array (define to be no smaller than 1024).


[row-major-order]: https://en.wikipedia.org/wiki/Row-_and_column-major_order
