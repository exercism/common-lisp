(ql:quickload "lisp-unit")
#-xlisp-test (load "perfect-numbers")

(defpackage #:perfect-numbers-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:perfect-numbers-test)


;; Perfect numbers tests:
(define-test smallest-perfect-number
  (assert-equal "perfect" (perfect-numbers:classify 6)))

(define-test medium-perfect-number
  (assert-equal "perfect" (perfect-numbers:classify 28)))

(define-test large-perfect-number
  (assert-equal "perfect" (perfect-numbers:classify 33550336)))


;; Abundant numbers tests:
(define-test smallest-abundant-number
  (assert-equal "abundant" (perfect-numbers:classify 12)))

(define-test medium-abundant-number
  (assert-equal "abundant" (perfect-numbers:classify 30)))

(define-test large-abundant-number
  (assert-equal "abundant" (perfect-numbers:classify 33550335)))


;; Deficient numbers tests:
(define-test smallest-prime-deficient-number
  (assert-equal "deficient" (perfect-numbers:classify 2)))

(define-test smallest-non-prime-deficient-number
  (assert-equal "deficient" (perfect-numbers:classify 1)))

(define-test medium-deficient-number
  (assert-equal "deficient" (perfect-numbers:classify 32)))

(define-test large-deficient-number
  (assert-equal "deficient" (perfect-numbers:classify 33550337)))


;; Undefined values of classify tests:
(define-test undefinded-0
  (assert-equal NIL (perfect-numbers:classify 0)))

(define-test undefined-negative
  (assert-equal NIL (perfect-numbers:classify -3)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
