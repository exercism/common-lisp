;; Ensures that isbn-verifier.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "isbn-verifier")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from isbn-verifier and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :isbn-verifier-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :isbn-verifier-test)

;; Define and enter a new FiveAM test-suite
(def-suite* isbn-verifier-suite)

(test valid-isbn
    (let ((isbn "3-598-21508-8"))
      (is-true (isbn-verifier:validp isbn))))

(test invalid-isbn-check-digit
    (let ((isbn "3-598-21508-9"))
      (is-false (isbn-verifier:validp isbn))))

(test valid-isbn-with-a-check-digit-of-10
    (let ((isbn "3-598-21507-X"))
      (is-true (isbn-verifier:validp isbn))))

(test check-digit-is-a-character-other-than-x
    (let ((isbn "3-598-21507-A"))
      (is-false (isbn-verifier:validp isbn))))

(test invalid-check-digit-in-isbn-is-not-treated-as-zero
    (let ((isbn "4-598-21507-B"))
      (is-false (isbn-verifier:validp isbn))))

(test invalid-character-in-isbn-is-not-treated-as-zero
    (let ((isbn "3-598-P1581-X"))
      (is-false (isbn-verifier:validp isbn))))

(test x-is-only-valid-as-a-check-digit
    (let ((isbn "3-598-2X507-9"))
      (is-false (isbn-verifier:validp isbn))))

(test valid-isbn-without-separating-dashes
    (let ((isbn "3598215088"))
      (is-true (isbn-verifier:validp isbn))))

(test isbn-without-separating-dashes-and-x-as-check-digit
    (let ((isbn "359821507X"))
      (is-true (isbn-verifier:validp isbn))))

(test isbn-without-check-digit-and-dashes
    (let ((isbn "359821507"))
      (is-false (isbn-verifier:validp isbn))))

(test too-long-isbn-and-no-dashes
    (let ((isbn "3598215078X"))
      (is-false (isbn-verifier:validp isbn))))

(test too-short-isbn
    (let ((isbn "00"))
      (is-false (isbn-verifier:validp isbn))))

(test isbn-without-check-digit
    (let ((isbn "3-598-21507"))
      (is-false (isbn-verifier:validp isbn))))

(test check-digit-of-x-should-not-be-used-for-0
    (let ((isbn "3-598-21515-X"))
      (is-false (isbn-verifier:validp isbn))))

(test empty-isbn
    (let ((isbn ""))
      (is-false (isbn-verifier:validp isbn))))

(test input-is-9-characters
    (let ((isbn "134456729"))
      (is-false (isbn-verifier:validp isbn))))

(test invalid-characters-are-not-ignored-after-checking-length
    (let ((isbn "3132P34035"))
      (is-false (isbn-verifier:validp isbn))))

(test invalid-characters-are-not-ignored-before-checking-length
    (let ((isbn "3598P215088"))
      (is-false (isbn-verifier:validp isbn))))

(test input-is-too-long-but-contains-a-valid-isbn
    (let ((isbn "98245726788"))
      (is-false (isbn-verifier:validp isbn))))

(defun run-tests (&optional (test-or-suite 'isbn-verifier-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
