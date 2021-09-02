# Introduction

In Common Lisp a function can have some arguments are are optional.
These are designated in the lambda list by `&optional` lambda list keyword.
A parameter will be bound to the value `nil` if it is not specified.
If there are several optional parameters they are bound in order.
Default values can be specified for optional parameters.
Finally a symbol an be specified for each optional parameter which will be bound to true or false depending on whether that parameter was supplied by the caller of the function (this is referred to as the "supplied-p parameter").

```lisp
(defun optional-parameters (&optional x (y 'default) (z nil z-supplied-p))
  (list x y (if z-supplied-p (list :z-was-supplied z)
                             (list :z-was-not-supplied z))))

(optional-parameters)          ;; => (NIL DEFAULT (:Z-WAS-NOT-SUPPLIED NIL))
(optional-parameters 5 nil 10) ;; => (5 NIL (:Z-WAS-SUPPLIED 10))
```
