;; Ensures that lucys-magnificent-mapper.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "lucys-magnificent-mapper")
  (ql:quickload :fiveam))

;; Defines the testing package with symbols from lucys-magnificent-mapper and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :lucys-magnificent-mapper-test
  (:use :cl :fiveam :lucys-magnificent-mapper)
  (:export :run-tests))

;; Enter the testing package
(in-package :lucys-magnificent-mapper-test)

;; Define and enter a new FiveAM test-suite
(def-suite lucys-magnificent-mapper-suite)
(in-suite lucys-magnificent-mapper-suite)

(defun double-n (n) (* 2 n))
(defun square (n) (expt n 2))
(defun square-minus-n (n) (- (square n) n))

(test doubly-magnificent
  (is (equal '(2 4 6 8 10) (make-magnificent-maybe #'double-n '(1 2 3 4 5)))))

(test magnificent-squared
  (is (equal '(1 4 9 16 25) (make-magnificent-maybe #'square '(1 2 3 4 5)))))

(test zooming-in-on-magnificent
  (is (equal '(0 2 6 12 20) (make-magnificent-maybe #'square-minus-n '(1 2 3 4 5)))))

(defun more-than-20 (n) (>= n 20))

(test not-too-big
  (is (equal '(10 15) (only-the-best #'more-than-20 '(10 15 20 25)))))

(test not-one
  (is (equal '(3) (only-the-best #'evenp '(1 2 3)))))

(test not-one-or-too-big
  (is (equal '(10 15) (only-the-best #'more-than-20 '(1 10 1 15 1 20 1 25 1)))))

(test nothing-good-enough
  (is (equal '() (only-the-best #'more-than-20 '(1 20 1 25 1)))))

(defun run-tests (&optional (test-or-suite 'lucys-magnificent-mapper-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
