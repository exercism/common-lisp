# Introduction

## Hash Tables

Hash tables in Common Lisp are data structures for storing associative data. 
They map keys (which can be any object) to values (which can be any object). 
Other languages may refer to this concept as maps, dictionaries or hashes.

### Creating hash tables

Hash tables can be created with the `make-hash-table` function.

`(make-hash-table) ; => #<HASH-TABLE :TEST EQL :COUNT 0 {10024AD2B3}>`

(Note the printed presentation of a hash table is implementation dependent so it may appear differently in your REPL.)

### Retrieving values by keys

To get a value by a key from the hash table you use the `gethash` function:

```lisp
*h* ; => #<HASH-TABLE :TEST EQL :COUNT 3 {10024AD2B3}>`
(gethash :foo *h*) ; => :bar
                   ;    T
```

`gethash` returns [multiple values][concept-multiple-values] which will be explained in another concept.

### Inserting values

To insert a value into a hash table you use `setf` with `gethash` like this:

`(setf (gethash :foo *hash-table*) :bar) ; => :bar`

This will modify the value for the key `:foo` in the hash table `*hash-table*` to be `:bar`.
It returns the value.

The use of `setf` will be explained in another concept.

[concept-multiple-values]: /tracks/common-lisp/concepts/multiple-values
