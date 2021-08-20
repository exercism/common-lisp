;; Ensures that binary.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "binary")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from binary and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :binary-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :binary-test)

;; Define and enter a new FiveAM test-suite
(def-suite* binary-suite)

(test binary-1-is-decimal-1 (is (equal 1 (binary:to-decimal "1"))))

(test binary-10-is-decimal-2 (is (equal 2 (binary:to-decimal "10"))))

(test binary-11-is-decimal-3 (is (equal 3 (binary:to-decimal "11"))))

(test binary-100-is-decimal-4 (is (equal 4 (binary:to-decimal "100"))))

(test binary-1001-is-decimal-9 (is (equal 9 (binary:to-decimal "1001"))))

(test binary-11010-is-decimal-26 (is (equal 26 (binary:to-decimal "11010"))))

(test binary-10001101000-is-decimal-1128
 (is (equal 1128 (binary:to-decimal "10001101000"))))

(test invalid-binary-is-decimal-0 (is (equal 0 (binary:to-decimal "carrot"))))

(test invalid-characters-at-beginning (is (equal 2 (binary:to-decimal "a10"))))

(test invalid-characters-at-end (is (equal 2 (binary:to-decimal "10a"))))

(test invalid-characters-in-middle (is (equal 2 (binary:to-decimal "1a0"))))

(test invalid-digits (is (equal 0 (binary:to-decimal "23"))))

(defun run-tests (&optional (test-or-suite 'binary-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
