;;; 
;;; hello-world v1.1.0
;;; 
(ql:quickload "lisp-unit")
#-xlisp-test (load "hello-world")

(defpackage #:hello-world-test
  (:use #:common-lisp #:lisp-unit))
(in-package #:hello-world-test)

(define-test
  say-hi!
  (assert-equal
    "Hello, World!"
    (hello-world:hello)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
