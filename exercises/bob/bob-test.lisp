;;;
;;; bob v1.6.0
;;;
(ql:quickload "lisp-unit")
#-xlisp-test (load "bob")

(defpackage #:bob-test
  (:use #:common-lisp #:lisp-unit))
(in-package #:bob-test)

(define-test
  stating-something
  (assert-equal
    "Whatever."
    (bob:response "Tom-ay-to, tom-aaaah-to.")))


(define-test
  shouting
  (assert-equal
    "Whoa, chill out!"
    (bob:response "WATCH OUT!")))


(define-test
  shouting-gibberish
  (assert-equal
    "Whoa, chill out!"
    (bob:response "FCECDFCAAB")))


(define-test
  asking-a-question
  (assert-equal
    "Sure."
    (bob:response "Does this cryogenic chamber make me look fat?")))


(define-test
  asking-a-numeric-question
  (assert-equal
    "Sure."
    (bob:response "You are, what, like 15?")))


(define-test
  asking-gibberish
  (assert-equal
    "Sure."
    (bob:response "fffbbcbeab?")))


(define-test
  talking-forcefully
  (assert-equal
    "Whatever."
    (bob:response "Hi there!")))


(define-test
  using-acronyms-in-regular-speech
  (assert-equal
    "Whatever."
    (bob:response "It's OK if you don't want to go work for NASA.")))


(define-test
  forceful-question
  (assert-equal
    "Calm down, I know what I'm doing!"
    (bob:response "WHAT'S GOING ON?")))


(define-test
  shouting-numbers
  (assert-equal
    "Whoa, chill out!"
    (bob:response "1, 2, 3 GO!")))


(define-test
  no-letters
  (assert-equal
    "Whatever."
    (bob:response "1, 2, 3")))


(define-test
  question-with-no-letters
  (assert-equal
    "Sure."
    (bob:response "4?")))


(define-test
  shouting-with-special-characters
  (assert-equal
    "Whoa, chill out!"
    (bob:response "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!")))


(define-test
  shouting-with-no-exclamation-mark
  (assert-equal
    "Whoa, chill out!"
    (bob:response "I HATE THE DENTIST")))


(define-test
  statement-containing-question-mark
  (assert-equal
    "Whatever."
    (bob:response "Ending with ? means a question.")))


(define-test
  non-letters-with-question
  (assert-equal
    "Sure."
    (bob:response ":) ?")))


(define-test
  prattling-on
  (assert-equal
    "Sure."
    (bob:response "Wait! Hang on. Are you going to be OK?")))


(define-test
  silence
  (assert-equal
    "Fine. Be that way!"
    (bob:response "")))


(define-test
  prolonged-silence
  (assert-equal
    "Fine. Be that way!"
    (bob:response "          ")))


(define-test
  alternate-silence
  (assert-equal
    "Fine. Be that way!"
    (bob:response "										")))


(define-test
  multiple-line-question
  (assert-equal
    "Whatever."
    (bob:response (format nil "~%
Does this cryogenic chamber make me look fat?~%
No."))))


(define-test
  starting-with-whitespace
  (assert-equal
    "Whatever."
    (bob:response "         hmmmmmmm...")))


(define-test
  ending-with-whitespace
  (assert-equal
    "Sure."
    (bob:response "Okay if like my  spacebar  quite a bit?   ")))


(define-test
  other-whitespace
  (assert-equal
    "Fine. Be that way!"
    (bob:response (format nil "~%
        "))))


(define-test
  non-question-ending-with-whitespace
  (assert-equal
    "Whatever."
    (bob:response "This is a statement ending with whitespace      ")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
