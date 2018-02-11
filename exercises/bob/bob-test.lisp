(ql:quickload "lisp-unit")
#-xlisp-test (load "bob")

(defpackage #:bob-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:bob-test)

(define-test responds-to-something
  (assert-equal "Whatever." (bob:response-for "Tom-ay-to, tom-aaaah-to.")))

(define-test responds-to-shouts
  (assert-equal "Whoa, chill out!" (bob:response-for "WATCH OUT!")))

(define-test shouting-gibberish
  (assert-equal "Whoa, chill out!" (bob:response-for "FCECDFCAAB")))

(define-test responds-to-questions
  (assert-equal "Sure." (bob:response-for "Does this cryogenic chamber make me look fat?")))

(define-test asking-a-numeric-question
  (assert-equal "Sure." (bob:response-for "You are, what, like 15?")))

(define-test asking-gibberish
  (assert-equal "Sure." (bob:response-for "fffbbcbeab?")))

(define-test responds-to-forceful-talking
  (assert-equal "Whatever." (bob:response-for "Let's go make out behind the gym!")))

(define-test responds-to-acronyms
  (assert-equal "Whatever." (bob:response-for "It's OK if you don't want to go to the DMV.")))

(define-test responds-to-forceful-questions
  (assert-equal "Calm down, I know what I'm doing!"
                (bob:response-for "WHAT THE HELL WERE YOU THINKING?")))

(define-test responds-to-shouting-numbers
  (assert-equal "Whoa, chill out!" (bob:response-for "1, 2, 3 GO!")))

(define-test responds-to-only-numbers
  (assert-equal "Whatever." (bob:response-for "1, 2, 3")))

(define-test responds-to-number-question
  (assert-equal "Sure." (bob:response-for "4?")))

(define-test responds-to-shouting-with-special-characters
  (assert-equal "Whoa, chill out!" (bob:response-for "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!")))

(define-test responds-to-shouting-with-no-exclamation-mark
  (assert-equal "Whoa, chill out!" (bob:response-for "I HATE YOU")))

(define-test responds-to-statement-containing-question-mark
  (assert-equal "Whatever." (bob:response-for "Ending with ? means a question.")))

(define-test non-letters-with-question
  (assert-equal "Sure." (bob:response-for ":) ?")))

(define-test prattling-ton
  (assert-equal "Sure." (bob:response-for "Wait! Hang on. Are you going to be OK?")))

(define-test responds-to-silence
  (assert-equal "Fine. Be that way!" (bob:response-for "")))

(define-test responds-to-prolonged-silence
  (assert-equal "Fine. Be that way!" (bob:response-for "    ")))

(define-test responds-to-alternate-silence
  (assert-equal "Fine. Be that way!"
                (bob:response-for (coerce (list #\Tab #\Tab #\Tab #\Tab) 'string))))

(define-test respond-to-multiline-question
  (assert-equal "Whatever."
                (bob:response-for (format nil "~%Does this cryogenic chamber make me look fat?~%no"))))

(define-test starting-with-whitespace
  (assert-equal "Whatever." (bob:response-for "         hmmmmmmm...")))

(define-test ending-with-whitespace
  (assert-equal "Sure." (bob:response-for "Okay if like my  spacebar  quite a bit?   ")))

(define-test other-whitespace
  (assert-equal "Fine. Be that way!"
                (bob:response-for (coerce (list #\Newline #\Tab #\Page) 'string))))

(define-test non-question-ending-with-whitespace
  (assert-equal "Whatever." (bob:response-for "This is a statement ending with whitespace      ")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
