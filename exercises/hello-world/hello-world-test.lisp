(ql:quickload "lisp-unit")
#-xlisp-test (load "hello-world")

(defpackage #:hello-world-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:hello-world-test)

(define-test hello-world-test
  (assert-equal "Hello World!" (hw:hello-world)))

(define-test hello-alice-test
  (assert-equal "Hello Alice!" (hw:hello-world "Alice")))

(define-test hello-bob-test
  (assert-equal "Hello Bob!" (hw:hello-world "Bob")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
