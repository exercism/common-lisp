# Introduction

## Truthy And Falsy

In Common Lisp, all values are `true` except for `nil` which is `false`.  `()` is another way to spell `nil`.
`nil` along with `t` are special constants which can be used for `false` or `true`.

## Conditionals

Common lisp provides several different conditional expressions, the main difference being the number of branches they support.

- `when` and `unless` allow for a single branch:

```lisp
(when (= 2 2) (+ 4 3))      ; => 7
(unless (= 2 2) (+ 4 3))    ; => NIL

(when (= 2 10) "All is well")        ; => NIL
(unless (= 2 10) "Time to panic!")   ; => "Time to panic!"
```
The section after the test expression may be more than one expression:
```lisp
(when (= 2 2) (print "hello world") (* 3 5))     ; prints "hello world" and returns 15
```

- `if` provides the classic if-then-else construct:

```lisp
(if (some-test)
    (true-part)
    (false-part))

(if (= 2 2)
    (+ 4 5)    
    (* 4 5))    
; => 9

(if (= 2 4)
    'how-honest
    'you-liar))
; => YOU-LIAR
```

Note that both the true-part and the false-part can only be a single expression.

- `cond` provides a way to have multiple branches without nesting `if` expressions:

```lisp
(cond ((= 0 2) 'nope)
      ((= 1 2) 'try-again)
      ((= 2 2) 'quite-true)
      ((= 3 2) 'too-far)
      (t 'something-else))
; => QUITE-TRUE
```
There is no limit to the number of expressions after a test expression in a branch. 

- `case` provides a classic 'switch' style construct: It checks a single value against a number of branches:

```lisp
(case :dog
  (:cat "Meow")
  (:bird "Chirp")
  (:dog "Bark")
  (otherwise "???"))]
; => "Bark"
```
Note that case can be tricky to use if you don't use keyword symbols because case compares 
whether the objects are identical. 

Here's another example of what you can do:

```lisp
(case :sparrow
  (:cat "Meow")
  ((:blackbird :sparrow :robin) "Chirp")
  (:dog "Bark")
  (otherwise "???"))
; => "Chirp"
```

There is no limit to the number of expressions after a test in a branch:
```lisp
(case :sparrow
  (:cat "Meow")
  ((:blackbird :sparrow :robin) (print "a bird") "Chirp")
  (:dog "Bark")
  (otherwise "???"))
; prints "a bird" and returns "Chirp"
```
Your compiler will probably issue some messages about the case statements above.  Because 
there are no variables, the compiler is able to determine which branch will 
execute before you even try to execute your code, so the compiler will inform you
that it is deleting the unreachable branches.  Here's a more practical example:

```lisp
(defun get-sound (animal)
  (case animal
    (:cat "Meow")
    ((:blackbird :sparrow :robin) "Chirp")
    (:dog "Bark")
    (otherwise "???")))
```

Then:

```
(get-sound :robin)    ; => "Chirp"
(get-sound :octopus   ; => "???"

```

