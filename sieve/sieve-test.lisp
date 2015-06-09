(ql:quickload "lisp-unit")

(defpackage #:sieve-test
  (:use #:common-lisp #:lisp-unit))

#-xlisp-test (load "sieve")

(in-package #:sieve-test)


#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :sieve-test))
