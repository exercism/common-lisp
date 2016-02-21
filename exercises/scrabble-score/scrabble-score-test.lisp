(ql:quickload "lisp-unit")

(defpackage #:scrabble-score-test
  (:use #:cl #:lisp-unit))

#-xlisp-test (load "scrabble-score")

(in-package #:scrabble-score-test)

(define-test no-word-has-zero-score
  (assert-equal 0 (scrabble-score:score-word "")))

(define-test whitespace-only-also-has-zero-score
  (assert-equal 0 (scrabble-score:score-word
                   (concatenate 'string '(#\Space #\Newline)))))

(define-test scores-small-word
  (assert-equal 1 (scrabble-score:score-word "a")))

(define-test is-case-insensitive
  (assert-equal 1 (scrabble-score:score-word "A")))

(define-test scores-a-slightly-bigger-word
  (assert-equal 2 (scrabble-score:score-word "at")))

(define-test scores-a-middle-of-the-road-word
  (assert-equal 6 (scrabble-score:score-word "street")))

(define-test scores-a-peculiar-word
  (assert-equal 22 (scrabble-score:score-word "quirky")))

(define-test scores-a-very-long-word
  (assert-equal 27 (scrabble-score:score-word "UNEXCLUSIVENESS")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :scrabble-score-test))
