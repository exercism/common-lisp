(ql:quickload "lisp-unit")
#-xlisp-test (load "raindrops")

(defpackage #:raindrops-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:raindrops-test)

(define-test test-1
    (assert-equal "1"
                  (raindrops:convert 1)))

(define-test test-3
    (assert-equal "Pling"
                  (raindrops:convert 3)))

(define-test test-5
    (assert-equal "Plang"
                  (raindrops:convert 5)))

(define-test test-7
    (assert-equal "Plong"
                  (raindrops:convert 7)))

(define-test test-6
    (assert-equal "Pling"
                  (raindrops:convert 6)))

(define-test test-9
    (assert-equal "Pling"
                  (raindrops:convert 9)))

(define-test test-10
    (assert-equal "Plang"
                  (raindrops:convert 10)))

(define-test test-15
    (assert-equal "PlingPlang"
                  (raindrops:convert 15)))

(define-test test-21
    (assert-equal "PlingPlong"
                  (raindrops:convert 21)))

(define-test test-25
    (assert-equal "Plang"
                  (raindrops:convert 25)))

(define-test test-35
    (assert-equal "PlangPlong"
                  (raindrops:convert 35)))

(define-test test-49
    (assert-equal "Plong"
                  (raindrops:convert 49)))

(define-test test-52
    (assert-equal "52"
                  (raindrops:convert 52)))

(define-test test-105
    (assert-equal "PlingPlangPlong"
                  (raindrops:convert 105)))

(define-test test-12121
    (assert-equal "12121"
                  (raindrops:convert 12121)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :raindrops-test))
