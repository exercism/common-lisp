# Introduction

Filtering is the process of creating a sequence from another sequence by copying all but certain elements from the original sequence.
The choice of which items to include in the new sequence can be done by a predicate function (a function that evaluates to a boolean value), or by equality with a specific object.

## Removing by a predicate

`remove-if` is a function that takes a function and a sequence and evaluates to a sequence of those elements for which the predicate evaluated to a false value.
If the predicate was true for all values then an empty sequence is returned.

```lisp
(remove-if #'evenp '(1 2 3 4 5)) ; => (1 3 5)
(remove-if #'oddp '(1 3 5))      ; => ()
```

## Removing a specific item

If one wants to remove a specific item from a sequence one can use `remove` which takes the item to remove and a sequence.
All values in the sequence which are not equal to the item to remove are returned.
NOTE: Equality is checked with the `eql` [generic equality predicate][concept-equality] by default.

```lisp
(remove 1 '(1 2 1 3 1 4)) ; => (2 3 4)
(remove #\l "hello")      ; => "heo"
```

[concept-equality]: /tracks/common-lisp/concepts/equality
