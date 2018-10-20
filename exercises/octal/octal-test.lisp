(ql:quickload "lisp-unit")
#-xlisp-test (load "octal")

(defpackage #:octal-test
  :use #:cl #:lisp-unit)

(in-package #:binary-test)

(define-test octal-1-is-decimal-1
  (assert-equal 1 (octal:to-decimal "1")))

(define-test octal-10-is-decimal-8
  (assert-equal 8 (octal:to-decimal "10")))

(define-test octal-17-is-decimal-15
  (assert-equal 15 (octal:to-decimal "17")))

(define-test octal-11-is-decimal-9
  (assert-equal 9 (octal:to-decimal "11")))

(define-test octal-130-is-decimal-88
  (assert-equal 88 (octal:to-decimal "130")))

(define-test octal-2047-is-decimal-1063
  (assert-equal 1063 (octal:to-decimal "2047")))

(define-test octal-7777-is-decimal-4095
  (assert-equal 4095 (octal:to-decimal "7777")))

(define-test octal-1234567-is-decimal-342391
  (assert-equal 342391 (octal:to-decimal "1234567")))

(define-test octal-011-is-decimal-9
  (assert-equal 9 (octal:to-decimal "011")))

(define-test octal-carrot-is-decimal-0
  (assert-equal 0 (octal:to-decimal "carrot")))

(define-test octal-8-is-decimal-0
  (assert-equal 0 (octal:to-decimal "8")))

(define-test octal-9-is-decimal-0
  (assert-equal 0 (octal:to-decimal "9")))

(define-test octal-6789-is-decimal-0
  (assert-equal 0 (octal:to-decimal "6789")))

(define-test octal-abc1z-is-decimal-0
  (assert-equal 0 (octal:to-decimal "abc1z")))


#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
