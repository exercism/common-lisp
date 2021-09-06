# About

Mapping refers to the application of a function to each element of a sequence to produce a new sequence.

`mapcar` can be used to map a function across a list of objects

```lisp
(mapcar #'double '(1 2 3 4)) ; => (2 4 6 8)
```

Notice that the first argument is a function to call. 
The `#'` is a special quoting syntax to specify a function.
(One can use `'double` here but the use of `#'` is idiomatic and arguably "more correct".)

## More than one list

Mapping is not limited to applying a function to a single sequence but can be done with multiple sequences.
If `N` sequences are provided then the function must take `N` arguments.

```lisp
(mapcar #'list '(1 2) '(a b) '("foo" "bar")) ; => ((1 a "foo") (2 b "bar"))
```

## Other map functions

In addition to `mapcar` there are other functions for mapping across lists.
`mapcar` is definitely the most common but it is good to know about the others.

`maplist` operates similarly to `mapcar` but operates on successive sublists rather than elements.
First to the entire list, then to `cdr`, then to the `cdr` of that etc.:

```lisp
(maplist #'identity '(a b c)) ; => ((A B C) (B C) (C))
```

`mapc` and `mapl` are like `mapcar` and `maplist` respectively but they do not collect the results and instead return the first list.
This is used for side-effecting operations.

`mapcan` and `mapcon` are like `mapcar` and `maplist` but the result is flattened by use of `nconc` which is like `append` but destructive to all but its last argument.

## Mapping on other sequences

Mapping is not limited to [lists][concept-lists]. Any sequence (covered in another concept) can be mapped over.
In the case of non-list sequences the `map` function is used.

`map` takes 3 or more arguments:
- the first is the type of resulting sequence
- the second is the function to apply
- the third and remaining are the sequences to operate on.

```lisp
(map 'list #'double '(1 2 3)) ; => (2 4 6)
(map 'string #'char-upcase "foobar") ; => "FOOBAR"
```

As a special case if `nil` is provided as the resulting sequence type then `nil` is returned.
This (like `mapc` and `mapl` above) are used for side-effects.

[concept-lists]: /tracks/common-lisp/concepts/lists
