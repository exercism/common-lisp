# Introduction

Mapping refers to the application of a function to each element of a sequence to produce a new sequence.

This can be done easily to a list with the function `mapcar`.
Let us assume we have a function `double` which multiplies its argument by `2`:

```lisp
(mapcar #'double '(1 2 3 4)) ; => (2 4 6 8)
```

Notice that the first argument is a function to call. The `#'` is a special quoting syntax to specify a function.

`double` was first called with the first element, then with the second, etc.
The results were collected into a list which is the value the expression evaluates to.

