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
    (let ((value ""))
      (is (string= "" (reverse-string:reverse-string value)))))

(test a-word
    (let ((value "robot"))
      (is (string= "tobor" (reverse-string:reverse-string value)))))

(test a-capitalized-word
    (let ((value "Ramen"))
      (is (string= "nemaR" (reverse-string:reverse-string value)))))

(test a-sentence-with-punctuation
    (let ((value "I'm hungry!"))
      (is (string= "!yrgnuh m'I" (reverse-string:reverse-string value)))))

(test a-palindrome
    (let ((value "racecar"))
      (is (string= "racecar" (reverse-string:reverse-string value)))))

(test an-even-sized-word
    (let ((value "drawer"))
      (is (string= "reward" (reverse-string:reverse-string value)))))

(test wide-characters
    (let ((value "子猫"))
      (is (string= "猫子" (reverse-string:reverse-string value)))))

(test grapheme-cluster-with-pre-combined-form
    (let ((value "Würstchenstand"))
      (is (string= "dnatsnehctsrüW" (reverse-string:reverse-string value)))))

(test grapheme-clusters
    (let ((value "ผู้เขียนโปรแกรม"))
      (is (string= "มรกแรปโนยขีเผู้" (reverse-string:reverse-string value)))))

(defun run-tests (&optional (test-or-suite 'reverse-string-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
