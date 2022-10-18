;; Ensures that matching-brackets.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "matching-brackets")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from matching-brackets and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :matching-brackets-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :matching-brackets-test)

;; Define and enter a new FiveAM test-suite
(def-suite* matching-brackets-suite)

(test paired-square-brackets
    (let ((value "[]"))
     (is-true (matching-brackets:pairedp value))))

(test empty-string
    (let ((value ""))
     (is-true (matching-brackets:pairedp value))))

(test unpaired-brackets
    (let ((value "[["))
     (is-false (matching-brackets:pairedp value))))

(test wrong-ordered-brackets
    (let ((value "}{"))
     (is-false (matching-brackets:pairedp value))))

(test wrong-closing-bracket
    (let ((value "{]"))
     (is-false (matching-brackets:pairedp value))))

(test paired-with-whitespace
    (let ((value "{ }"))
     (is-true (matching-brackets:pairedp value))))

(test partially-paired-brackets
    (let ((value "{[])"))
     (is-false (matching-brackets:pairedp value))))

(test simple-nested-brackets
    (let ((value "{[]}"))
     (is-true (matching-brackets:pairedp value))))

(test several-paired-brackets
    (let ((value "{}[]"))
     (is-true (matching-brackets:pairedp value))))

(test paired-and-nested-brackets
    (let ((value "([{}({}[])])"))
     (is-true (matching-brackets:pairedp value))))

(test paired-and-wrong-nested-brackets-but-innermost-are-correct
    (let ((value "[({}])"))
     (is-false (matching-brackets:pairedp value))))

(test unopened-closing-brackets
    (let ((value "{[)][]}"))
     (is-false (matching-brackets:pairedp value))))

(test unpaired-and-nested-brackets
    (let ((value "([{])"))
     (is-false (matching-brackets:pairedp value))))

(test paired-and-wrong-nested-brackets
    (let ((value "[({]})"))
     (is-false (matching-brackets:pairedp value))))

(test paired-and-incomplete-brackets
    (let ((value "{}["))
     (is-false (matching-brackets:pairedp value))))

(test too-many-closing-brackets
    (let ((value "[]]"))
     (is-false (matching-brackets:pairedp value))))

(test early-unexpected-brackets
    (let ((value ")()"))
     (is-false (matching-brackets:pairedp value))))

(test early-mismatched-brackets
    (let ((value "{)()"))
     (is-false (matching-brackets:pairedp value))))

(test math-expression
    (let ((value "(((185 + 223.85) * 15) - 543)/2"))
     (is-true (matching-brackets:pairedp value))))

(test complex-latex-expression
    (let ((value "\left(\begin{array}{cc} \frac{1}{3} & x\\ \mathrm{e}^{x} &... x^2 \end{array}\right)"))
     (is-true (matching-brackets:pairedp value))))

(defun run-tests (&optional (test-or-suite 'matching-brackets-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))

