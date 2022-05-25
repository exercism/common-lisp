;; Ensures that pangram.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "pangram")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from pangram and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :pangram-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :pangram-test)

;; Define and enter a new FiveAM test-suite
(def-suite* pangram-suite)

(test empty-sentence
    (let ((sentence ""))
      (is-false (pangram:pangramp sentence))))

(test perfect-lower-case
    (let ((sentence "abcdefghijklmnopqrstuvwxyz"))
      (is-true (pangram:pangramp sentence))))

(test only-lower-case
    (let ((sentence "the quick brown fox jumps over the lazy dog"))
      (is-true (pangram:pangramp sentence))))

(test missing-the-letter-x
    (let ((sentence "a quick movement of the enemy will jeopardize five gunboats"))
      (is-false (pangram:pangramp sentence))))

(test missing-the-letter-h
    (let ((sentence "five boxing wizards jump quickly at it"))
      (is-false (pangram:pangramp sentence))))

(test with-underscores
    (let ((sentence "the_quick_brown_fox_jumps_over_the_lazy_dog"))
      (is-true (pangram:pangramp sentence))))

(test with-numbers
    (let ((sentence "the 1 quick brown fox jumps over the 2 lazy dogs"))
      (is-true (pangram:pangramp sentence))))

(test missing-letters-replaced-by-numbers
    (let ((sentence "7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"))
      (is-false (pangram:pangramp sentence))))

(test mixed-case-and-punctuation
    (let ((sentence "\"Five quacking Zephyrs jolt my wax bed.\""))
      (is-true (pangram:pangramp sentence))))

(test case-insensitive
    (let ((sentence "the quick brown fox jumps over with lazy FX"))
      (is-false (pangram:pangramp sentence))))

(test a-m-and-a-m-are-26-different-characters-but-not-a-pangram
    (let ((sentence "abcdefghijklm ABCDEFGHIJKLM"))
      (is-false (pangram:pangramp sentence))))

(defun run-tests (&optional (test-or-suite 'pangram-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
