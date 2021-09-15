# About

In Common Lisp a function can not only return one value but can return multiple values. 
For example `floor` which rounds down toward zero, returns two values, the first is the rounded value and the second is the remainder.

```lisp
(floor 3.5) ; => 3
            ;    0.5
```
(We will show multiple values returned on separate lines of the output.)

## Return multiple values

If you want a function to return multiple values you use the `values` accessor:

```lisp
(defun three-numbers () (values 1 2 3))
(three-numbers) ; => 1
                ;    2
                ;    3
```

If you have a list of values you want to return then `value-list` can be used:

```lisp
(values-list '(a b c)) ; => a
                       ;    b
                       ;    c
```
## Handling multiple values

If you only care about the first value then nothing special needs to be done - the language takes care of it:

```lisp
(+ (values 1 2 3) (values 10 20 30)) ; => 11
```

However if you want to access those other values there are several functions you'll need to use. 

Two main macros are `multiple-value-list` and `multiple-value-bind`.
These are used to wrap something that return multiple values and captures all the values.
The first will create a list of all the values.
The second will let you bind variables to the individual values.

```lisp
(multiple-value-list (values 1 2 3))                   ; => (1 2 3)
(multiple-value-bind (a b c) (values 1 2 3) 
   (+ a b c)) ; => 6
```

Another useful macro is `nthvalue`. This is like `nth` for lists in that it returns the "nth" item from a set of multiple values:

```lisp
(nth-value 0 (values 1 2 3 )) ; => 1
(nth-value 1 (values 1 2 3 )) ; => 2
(nth-value 2 (values 1 2 3 )) ; => 3
```


