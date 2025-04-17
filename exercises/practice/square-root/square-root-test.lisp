;; Ensures that square-root.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "square-root")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from square-root and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :square-root-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :square-root-test)

;; Define and enter a new FiveAM test-suite
(def-suite* square-root-suite)

(test root-of-1
    (let ((radicand 1))
      (is (= 1 (square-root:square-root radicand)))))

(test root-of-4
    (let ((radicand 4))
      (is (= 2 (square-root:square-root radicand)))))

(test root-of-25
    (let ((radicand 25))
      (is (= 5 (square-root:square-root radicand)))))

(test root-of-81
    (let ((radicand 81))
      (is (= 9 (square-root:square-root radicand)))))

(test root-of-196
    (let ((radicand 196))
      (is (= 14 (square-root:square-root radicand)))))

(test root-of-65025
    (let ((radicand 65025))
      (is (= 255 (square-root:square-root radicand)))))

(defun run-tests (&optional (test-or-suite 'square-root-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
