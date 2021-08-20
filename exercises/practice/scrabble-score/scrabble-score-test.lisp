;; Ensures that scrabble-score.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "scrabble-score")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from scrabble-score and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :scrabble-score-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :scrabble-score-test)

;; Define and enter a new FiveAM test-suite
(def-suite* scrabble-score-suite)

(test no-word-has-zero-score (is (equal 0 (scrabble-score:score-word ""))))

(test whitespace-only-also-has-zero-score
 (is
  (equal 0 (scrabble-score:score-word (concatenate 'string '(#\  #\Newline))))))

(test scores-small-word (is (equal 1 (scrabble-score:score-word "a"))))

(test is-case-insensitive (is (equal 1 (scrabble-score:score-word "A"))))

(test scores-a-slightly-bigger-word
 (is (equal 2 (scrabble-score:score-word "at"))))

(test scores-a-middle-of-the-road-word
 (is (equal 6 (scrabble-score:score-word "street"))))

(test scores-a-peculiar-word
 (is (equal 22 (scrabble-score:score-word "quirky"))))

(test scores-a-very-long-word
 (is (equal 27 (scrabble-score:score-word "UNEXCLUSIVENESS"))))

(defun run-tests (&optional (test-or-suite 'scrabble-score-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
