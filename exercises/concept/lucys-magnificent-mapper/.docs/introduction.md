# Introduction

## Mapping

Mapping refers to the application of a function to each element of a sequence to produce a new sequence.

This can be done easily to a list with the function `mapcar`.
Let us assume we have a function `double` which multiplies its argument by `2`:

```lisp
(mapcar #'double '(1 2 3 4)) ; => (2 4 6 8)
```

Notice that the first argument is a function to call. The `#'` is a special quoting syntax to specify a function.

`double` was first called with the first element, then with the second, etc.
The results were collected into a list which is the value the expression evaluates to.

## Filtering

Filtering is the process of creating a sequence from another sequence by copying all but certain elements from the original sequence.
The choice of which items to include in the new sequence can be done by a predicate function (a function that evaluates to a boolean value), or by equality with a specific object.

### Removing by a predicate

`remove-if` is a function that takes a predicate function and a sequence as arguments, and returns a sequence of only those elements for which the predicate evaluated to a false value.
In other words, it "removes" all elements of the sequence for which the predicate evaluates to true. However, note that this function does not modify the original sequence! 
Instead, it returns a new sequence without the appropriate elements. If the predicate was true for all values then an empty sequence is returned.

```lisp
(remove-if #'evenp '(1 2 3 4 5)) ; => (1 3 5)
(remove-if #'oddp '(1 3 5))      ; => ()
```

### Removing a specific item

If one wants to remove a specific item from a sequence one can use `remove` which takes the item to remove and a sequence.
All values in the sequence which are not equal to the item to remove are returned.
NOTE: Equality is checked with the `eql` [generic equality predicate][concept-equality] by default.

```lisp
(remove 1 '(1 2 1 3 1 4)) ; => (2 3 4)
(remove #\l "hello")      ; => "heo"
```

[concept-equality]: /tracks/common-lisp/concepts/equality
