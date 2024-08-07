# About

Reducing is the repeated application of a function to each element of
a sequence and accumulating, in some way, the results. 
The function applied takes two parameters: the current accumulated value and the item to process. 
It must evaluate to the new accumulated value.

This is called accumulate or fold in some programming languages.

In Common Lisp the process is done with the `reduce` function.
In its simplest form it looks like:

`(reduce #'function-to-apply sequence :initial-value value)`

Notice that an initial value is provided - this will be the 'current accumulated value' that is passed into the function when the first element is processed.

Here is an example which adds the numbers of the list together starting with an initial value of 10:

`(reduce #'+ '(1 2 3 4) :initial-value 10) ; => 20`

Note that if the sequence is empty the function is never called and the form evaluates to the initial-value.

## Specifying the initial value or not

The `:initial-value` argument is not mandatory and `reduce` acts differently depending on if it was provided and if the sequence has elements.

1. If the initial-value is not provided and the sequence has more than one element then the first time the function is called it is called with the first two elements of the sequence.
2. If the initial-value is not provided and the sequence has one element then the form evaluates to that element and the function is not called.
3. If the initial-value is provided and the sequence is empty then the form evaluates to the initial value and the function is not called.
4. If the initial-value is not provided and the sequence is empty then the function is called with *zero* arguments.

The last case is one that can trip people up.
It is usually easy to provide an initial value so that the program never gets to this odd case.

## Other keyword arguments

`reduce` takes some other keyword arguments which may be useful in some cases.

* `:start` and `:end`: these specify indices into the sequence which cause reduce to work on a sub-sequence. They default to `0` and `nil`, respectively, meaning the beginning and end of the sequence.
* `:from-end` if this generalized boolean evaluates true then instead of working left-to-right, the reduction will happen right-to-left.
* `:key` specifies a function to be called on each element *before* it is given to the reduction function. This function is *not* applied to the value specified as `:initial-value`.

Some examples:

```lisp
(reduce #'+ '(1 2 3 4 5 6 7 8 9 10) 
        :start 2 :end 5)               ; => 12 (only adds 3, 4, 5)
(reduce #'cons '(1 2 3))               ; => ((1 . 2) . 3)
(reduce #'cons '(1 2 3) :from-end t)   ; => (1 2 . 3)
(reduce #'+ '((1) (2) (3)) :key #'car) ; => 6
```

