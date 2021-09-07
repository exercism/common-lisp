# About

[Lists][hyper-cons-as-list] are a very common data type in Common Lisp.
They are made up of a sequence of [cons][../cons/about.md] cells.
Each `car` is an element of the list and every `cdr` is a either the next cons cell or a terminating atom.

A list which terminates with the empty list is called a "proper list".

A list which terminates with an atom that is not th empty list is called a "dotted list" (based upon how it is printed: `(cons 'a 'b) ;=> (a . b)`).

A list can also be circular if some cons cell in the list `cdr` of a later cons cell.
For example: `(let ((x (list 1))) (setf (cdr x) x) (write x :stream t :circle t) :done)`.
Take care when working with circular lists as allowing them to be printed out without binding [`*print-circle*`][hyper-print-circle] to `t` will cause an infinite loop and will lock up the REPL (in this example by specifying `:circle t` to `write`, `*print-circle` will be bound to `t`).

## Combining lists

You can call `append` with any number of lists, including 1 or 0:

```lisp
(append '(a b c) '(1 2 3)) ; => (A B C 1 2 3)
(append '(a b c) '()))     ; => (A B C)
(append '(a b c))          ; => (A B C)
(append)                   ; => ()
```

As an alternative to `append` there is `nconc` which has the same result but has the side-effect of modifying the lists. You should be careful when using `nconc` as it may have surprising effects.

[hyper-cons-as-list]: http://l1sp.org/cl/14.1.2
[hyper-print-circle]: http://l1sp.org/cl/*print-circle*
