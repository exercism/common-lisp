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

(test lowercase-letter
    (let ((word "a"))
      (is (= 1 (scrabble-score:score-word word)))))

(test uppercase-letter
    (let ((word "A"))
      (is (= 1 (scrabble-score:score-word word)))))

(test valuable-letter
    (let ((word "f"))
      (is (= 4 (scrabble-score:score-word word)))))

(test short-word
    (let ((word "at"))
      (is (= 2 (scrabble-score:score-word word)))))

(test short-valuable-word
    (let ((word "zoo"))
      (is (= 12 (scrabble-score:score-word word)))))

(test medium-word
    (let ((word "street"))
      (is (= 6 (scrabble-score:score-word word)))))

(test medium-valuable-word
    (let ((word "quirky"))
      (is (= 22 (scrabble-score:score-word word)))))

(test long-mixed-case-word
    (let ((word "OxyphenButazone"))
      (is (= 41 (scrabble-score:score-word word)))))

(test english-like-word
    (let ((word "pinata"))
      (is (= 8 (scrabble-score:score-word word)))))

(test empty-input
    (let ((word ""))
      (is (= 0 (scrabble-score:score-word word)))))

(test entire-alphabet-available
    (let ((word "abcdefghijklmnopqrstuvwxyz"))
      (is (= 87 (scrabble-score:score-word word)))))

(defun run-tests (&optional (test-or-suite 'scrabble-score-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
