(ql:quickload "lisp-unit")

(defpackage #:scrabble-score-test
  (:use #:cl #:lisp-unit))

(load "scrabble-score")

(in-package #:scrabble-score-test)

(define-test lower-case-letter
  (assert-equal 1 (scrabble-score:score-letter #\a)))

(define-test upper-case-letter
  (assert-equal 1 (scrabble-score:score-letter #\A)))

(define-test two-letter-word
  (assert-equal 2 (scrabble-score:score-word "at")))

(define-test bigger-word-1
  (assert-equal 6 (scrabble-score:score-word "street")))

(define-test bigger-word-2
  (assert-equal 22 (scrabble-score:score-word "quirky")))

(define-test all-upper-case-word
  (assert-equal 20 (scrabble-score:score-word "MULTIBILLIONAIRE")))

(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :scrabble-score-test))
