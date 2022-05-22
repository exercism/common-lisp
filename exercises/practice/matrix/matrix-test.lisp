;; Ensures that matrix.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "matrix")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from matrix and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :matrix-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :matrix-test)

;; Define and enter a new FiveAM test-suite
(def-suite* matrix-suite)

(test extract-row-from-one-number-matrix
    (let ((input-matrix "1")
          (index 1))
      (is (equal (list 1) (matrix:row input-matrix index)))))

(test can-extract-row
    (let ((input-matrix (format nil "~{~A~&~}" '("1 2"
                                                 "3 4")))
          (index 2))
      (is (equal (list 3 4) (matrix:row input-matrix index)))))

(test extract-row-where-numbers-have-different-widths
    (let ((input-matrix (format nil "~{~A~&~}" '("1 2"
                                                 "10 20")))
          (index 2))
      (is (equal (list 10 20) (matrix:row input-matrix index)))))

(test can-extract-row-from-non-square-matrix-with-no-corresponding-column
    (let ((input-matrix (format nil "~{~A~&~}" '("1 2 3"
                                                 "4 5 6"
                                                 "7 8 9"
                                                 "8 7 6")))
          (index 4))
      (is (equal (list 8 7 6) (matrix:row input-matrix index)))))

(test extract-column-from-one-number-matrix
    (let ((input-matrix "1")
          (index 1))
      (is (equal (list 1) (matrix:column input-matrix index)))))

(test can-extract-column
    (let ((input-matrix (format nil "~{~A~&~}" '("1 2 3"
                                                 "4 5 6"
                                                 "7 8 9")))
          (index 3))
      (is (equal (list 3 6 9) (matrix:column input-matrix index)))))

(test can-extract-column-from-non-square-matrix-with-no-corresponding-row
    (let ((input-matrix (format nil "~{~A~&~}" '("1 2 3 4"
                                                 "5 6 7 8"
                                                 "9 8 7 6")))
          (index 4))
      (is (equal (list 4 8 6) (matrix:column input-matrix index)))))

(test extract-column-where-numbers-have-different-widths
    (let ((input-matrix (format nil "~{~A~&~}" '("89 1903 3"
                                                 "18 3 1"
                                                 "9 4 800")))
          (index 2))
      (is (equal (list 1903 3 4) (matrix:column input-matrix index)))))

(defun run-tests (&optional (test-or-suite 'matrix-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
