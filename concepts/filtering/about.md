# About

Filtering is the process of creating a sequence from another sequence by copying all but certain elements from the original sequence.
The choice of which items to include in the new sequence can be done by a predicate function (a function that evaluates to a boolean value), or by equality with a specific object.

## Removing by a predicate

`remove-if` is a function that takes a function and a sequence and evaluates to a sequence of those elements for which the predicate evaluated to a false value.
If the predicate was true for all values then an empty sequence is returned.

```lisp
(remove-if #'evenp '(1 2 3 4 5)) ; => (1 3 5)
(remove-if #'oddp '(1 3 5))      ; => ()
```

## Keeping elements by a predicate

There is a function `remove-if-not` which is just like `remove-if` except that it *keeps* the element that the predicate evaluates to true for.

As an alternative one can use `complement` to change a predicate into its 'opposite'.

```lisp
(remove-if #'evenp '(1 2 3 4 5 6))             ; => (1 3 5)
(remove-if-not #'oddp '(1 2 3 4 5 6))          ; => (1 3 5)
(remove-if (complement #'oddp) '(1 2 3 4 5 6)) ; => (1 3 5)
```

## Removing a specific item

If one wants to remove a specific item from a sequence one can use `remove` which takes the item to remove and a sequence.
All values in the sequence which are not equal to the item to remove are returned.

```lisp
(remove 1 '(1 2 1 3 1 4)) ; => (2 3 4)
(remove #\l "hello")      ; => "heo"
```

The function to use for equality can be specified with the `:test` [keyword parameter][concept-keyword-parameters].

Note that `remove` could be implemented with `remove-if` by writing a predicate that tests an object for equality to a specific item.

## Lots of options

Each of these functions also take many other [keyword parameters][concept-keyword-parameters] which allow them to work on only subsequences, only apply a certain number of times and others. Looks to the [Hyperspec documentation][hyperspec-remove] for full details


## Destructive options

In addition to `remove`, `remove-if` and `remove-if-not` there are `delete`, `delete-if` and `delete-if-not` which have the equivalent affect except they may modify the sequence passed to them.


[concept-keyword-parameters]: /tracks/common-lisp/concepts/keyword-parameters
[hyperspec-remove]: http://www.lispworks.com/documentation/HyperSpec/Body/f_rm_rm.htm

