# Introduction

## Lists

Given that the name of the language we're using, Lisp, stands for _LIST Processing_, one might assume that the language has facilities for handling lists of items, and you'd be correct!

While Common Lisp has data structures other than lists, lists are still heavily used.

A list in Common Lisp is a sequence of items. It's also called a **cons** (for historical reasons, mostly).
The items themselves do not have to be the same type.
For example you can have a list of `1`, `two`, `"III"`.

### Creating Lists

You can simply type in a quoted list like this: `'(1 two "III")` and that will cause a list to be created and evaluated (it evaluates to `(1 two "III")`).

There are also two main functions used to create lists: `list` and `cons`.

`list` takes zero or more arguments and evaluates to a list created with those values:

```lisp
(list 1 'two "III") ; => (1 two "III")
```

`cons` takes two items and creates a list which has the first item as its `car` (the list head) and the second item as its `cdr` (the rest of the list):

```lisp
(cons 1 2)            ; => (1 . 2) ;; (a list without `nil` as its `cdr` is printed in this way)
(cons 1 nil)          ; => (1)
(cons 1 (cons 2 nil)) ; => (1 2)
```

The functions `car` and `cdr` can be used to access the `car` and `cdr` of a list.

(`first` and `rest` are synonyms of `car` and `cdr` and work exactly the same.)

### Length & Random Access

The length of a list can be determined by the use of `length`.
An empty list has length zero.

An arbitrary item can be accessed with `nth` (note that lists are zero-indexed).

It is _not_ an error to request an index that is bigger than the list is long.
Instead, it evaluates to `nil`:

```lisp
(nth 23 '(short list))` ; => nil
```

There are also several helper methods for accessing the first items of a list: `first`, `second`, `third`, all the way until `tenth`. Nifty, huh?

### Combining lists

Two or more lists can be combined with `append`: 

```lisp
(append '(a b c) '(1 2 3)) ; => (A B C 1 2 3)
(append '(a b c) '()))     ; => (A B C)
```

Each argument given to `append` needs to be a list.
