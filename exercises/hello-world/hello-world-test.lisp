(ql:quickload "lisp-unit")
#-xlisp-test (load "hello-world")

(defpackage #:hello-world-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:hello-world-test)

(define-test hello-world-test
  (assert-equal "Hello, World!" (hw:hello-world)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
