;; Ensures that reverse-string.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "reverse-string")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from reverse-string and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :reverse-string-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :reverse-string-test)

;; Define and enter a new FiveAM test-suite
(def-suite* reverse-string-suite)

(test an-empty-string
    (let ((input-string ""))
      (is (string= "" (reverse-string:reverse-string input-string)))))

(test a-word
    (let ((input-string "robot"))
      (is (string= "tobor" (reverse-string:reverse-string input-string)))))

(test a-capitalized-word
    (let ((input-string "Ramen"))
      (is (string= "nemaR" (reverse-string:reverse-string input-string)))))

(test a-sentence-with-punctuation
    (let ((input-string "Im hungry!"))
      (is (string= "!yrgnuh mI" (reverse-string:reverse-string input-string)))))

(test a-palindrome
    (let ((input-string "racecar"))
      (is (string= "racecar" (reverse-string:reverse-string input-string)))))

(test an-even-sized-word
    (let ((input-string "drawer"))
      (is (string= "reward" (reverse-string:reverse-string input-string)))))

(defun run-tests (&optional (test-or-suite 'reverse-string-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
