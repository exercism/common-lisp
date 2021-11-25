# About

[Conses][hyper-conses] are a basic data type in Common Lisp. They are composed of a head and a tail (called for [historical reason][history] the `car` and the `cdr`). 
There is no restriction on the data types of the head and tail of a cons.

Conses are created with the [`cons`][hyper-cons] function which takes two objects and evaluates to a cons (also sometimes termed a 'cons cell').

The parts of a cons may be accessed with the functions [`car`][hyper-car] and [`cdr`][hyper-cdr].

## Reference

```lisp
;; Testing for atoms
(atom 'foo)              ; => T
(atom '(bar baz))        ; => NIL

;; Testing for cons
(consp 'foo)             ; => NIL
(consp '(bar baz))       ; => T

;; First item of a cons
(car '(one two three))   ; => ONE
(first '(one two three)) ; => ONE

;; Rest of a cons
(cdr '(one two three))   ; => (TWO THREE)
(rest '(one two three))  ; => (TWO THREE)
```

[history]: https://en.wikipedia.org/wiki/CAR_and_CDR#Etymology
[hyper-car]: http://www.lispworks.com/documentation/HyperSpec/Body/f_car_c.htm
[hyper-cdr]: http://www.lispworks.com/documentation/HyperSpec/Body/f_car_c.htm
[hyper-cons]: http://www.lispworks.com/documentation/HyperSpec/Body/f_cons.htm
[hyper-conses]: http://www.lispworks.com/documentation/HyperSpec/Body/14_.htm
