(ql:quickload "lisp-unit")
#-xlisp-test (load "all-your-base")

(defpackage #:all-your-base-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:all-your-base-test)

;; insert tests here...

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :all-your-base-test))
