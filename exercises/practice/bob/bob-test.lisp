;; Ensures that bob.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "bob")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from bob and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :bob-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :bob-test)

;; Define and enter a new FiveAM test-suite
(def-suite* bob-suite)

(test stating-something
 (is (equal "Whatever." (bob:response "Tom-ay-to, tom-aaaah-to."))))

(test shouting (is (equal "Whoa, chill out!" (bob:response "WATCH OUT!"))))

(test shouting-gibberish
 (is (equal "Whoa, chill out!" (bob:response "FCECDFCAAB"))))

(test asking-a-question
 (is
  (equal "Sure."
         (bob:response "Does this cryogenic chamber make me look fat?"))))

(test asking-a-numeric-question
 (is (equal "Sure." (bob:response "You are, what, like 15?"))))

(test asking-gibberish (is (equal "Sure." (bob:response "fffbbcbeab?"))))

(test talking-forcefully (is (equal "Whatever." (bob:response "Hi there!"))))

(test using-acronyms-in-regular-speech
 (is
  (equal "Whatever."
         (bob:response "It's OK if you don't want to go work for NASA."))))

(test forceful-question
 (is
  (equal "Calm down, I know what I'm doing!"
         (bob:response "WHAT'S GOING ON?"))))

(test shouting-numbers
 (is (equal "Whoa, chill out!" (bob:response "1, 2, 3 GO!"))))

(test no-letters (is (equal "Whatever." (bob:response "1, 2, 3"))))

(test question-with-no-letters (is (equal "Sure." (bob:response "4?"))))

(test shouting-with-special-characters
 (is
  (equal "Whoa, chill out!"
         (bob:response "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!"))))

(test shouting-with-no-exclamation-mark
 (is (equal "Whoa, chill out!" (bob:response "I HATE THE DENTIST"))))

(test statement-containing-question-mark
 (is (equal "Whatever." (bob:response "Ending with ? means a question."))))

(test non-letters-with-question (is (equal "Sure." (bob:response ":) ?"))))

(test prattling-on
 (is (equal "Sure." (bob:response "Wait! Hang on. Are you going to be OK?"))))

(test silence (is (equal "Fine. Be that way!" (bob:response ""))))

(test prolonged-silence
 (is (equal "Fine. Be that way!" (bob:response "          "))))

(test alternate-silence
 (is (equal "Fine. Be that way!" (bob:response "										"))))

(test multiple-line-question
 (is
  (equal "Whatever."
         (bob:response
          (format nil "~%
Does this cryogenic chamber make me look fat?~%
No.")))))

(test starting-with-whitespace
 (is (equal "Whatever." (bob:response "         hmmmmmmm..."))))

(test ending-with-whitespace
 (is
  (equal "Sure." (bob:response "Okay if like my  spacebar  quite a bit?   "))))

(test other-whitespace
 (is
  (equal "Fine. Be that way!"
         (bob:response
          (format nil "~%
        ")))))

(test non-question-ending-with-whitespace
 (is
  (equal "Whatever."
         (bob:response "This is a statement ending with whitespace      "))))

(defun run-tests (&optional (test-or-suite 'bob-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
