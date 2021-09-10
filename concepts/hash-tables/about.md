# About

Hash tables in Common Lisp are data structures for storing associative data. 
They map keys (which can be any object) to values (which can be any object). 

## Creating hash tables

Hash tables can be created with the `make-hash-table` function.

The `make-hash-table` function takes several [keyword parameters][concept-keyword-parameters] for fine-tuning the initial size of the hash table as well as its resizing threshold; refer to the [documentation][hyperspec-make-hash-table] for full info on those.
More importantly it also takes a `test` [keyword parameter][concept-keyword-parameters] which defines how keys are compared during the insertion, lookup and removal of keys and values.
The values of the `test` argument can be one of `'eq`, `'eql`, `'equal`, or `'equalp` which correspond to the [generic equality predicates][concept-equality]. 
The default value is `'eql`.

## Common operations on hash tables

To get a value by its key one uses `gethash`.
`gethash` takes an [optional argument][concept-defualt-arguments] which acts as the value to be returned if the key is not present in the hash table.
`gethash` also returns _multiple values_ (explained in another concept). 
The first value is the value of that key in the hash table, the default value if provided, or `NIL`.
The second value is a boolean that indicates if the key was present in the hash table or not.

To insert a key value pair one uses `setf` with `gethash`.

To remove a key and its value use `remhash`.

To remove all keys and values use `clrhash`


While a hash table in Common Lisp, as in other languages, has no guaranteed ordering, it can sometimes be useful to iterate over one processing each key/value pair.
This can be done with `maphash`:

```lisp
(maphash #'(lambda (key value) (print (cons key value))) *hash-table*)
```
(This will print out each key and value as a cons-pair, one per line.)

## Reference

```lisp
(setf *hash-table* (make-hash-table))     ; => #<HASH-TABLE :TEST EQL :COUNT 0 {100375FD23}>
(gethash :foo *hash-table*)               ; => NIL
                                          ;    NIL
(gethash :foo *hash-table* 
         :default-value)                  ; => :DEFAULT-VALUE
                                          ;    NIL

(setf (gethash :foo *hash-table*) :bar)   ; => :BAR
(gethash :foo *hash-table*)               ; => :BAR
                                          ;    T

(setf (gethash :key *hash-table*) :value) ; => :RIGHT
(gethash :key *hash-table*)               ; => :VALUE
                                          ;    T

(remhash :key *hash-table*)               ; => T
(gethash :key *hash-table*)               ; => NIL
                                          ; => NIL
                            
(clrhash *hash-table*)                    ; => #<HASH-TABLE :TEST EQL :COUNT 0 {1005A90103}>
(gethash :foo *hash-table*)               ; => NIL
                                          ;    NIL
```

[concept-default-arguments]: /tracks/common-lisp/concepts/default-arguments
[concept-equality]: /tracks/common-lisp/concepts/equality
[concept-keyword-parameters]: /tracks/common-lisp/concepts/keyword-parameters
[hyperspec-make-hash-table]: http://www.lispworks.com/documentation/HyperSpec/Body/f_mk_has.htm#make-hash-table
