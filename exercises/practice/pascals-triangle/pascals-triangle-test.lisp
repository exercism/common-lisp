;; Ensures that pascals-triangle.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
           (load "pascals-triangle")
           (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from pascals-triangle and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :pascals-triangle-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :pascals-triangle-test)

;; Define and enter a new FiveAM test-suite
(def-suite* pascals-triangle-suite)

(test zero-rows
      (let ((count 0))
        (is (equal '() (pascals-triangle:rows count)))))

(test single-row
      (let ((count 1))
        (is (equal '((1)) (pascals-triangle:rows count)))))

(test two-rows
      (let ((count 2))
        (is (equal '((1)
                     (1 1)) (pascals-triangle:rows count)))))

(test three-rows
      (let ((count 3))
        (is (equal '((1)
                     (1 1)
                     (1 2 1)) (pascals-triangle:rows count)))))

(test four-rows
      (let ((count 4))
        (is (equal '((1)
                     (1 1)
                     (1 2 1)
                     (1 3 3 1)) (pascals-triangle:rows count)))))

(test five-rows
      (let ((count 5)
            (result '((1)
                      (1 1)
                      (1 2 1)
                      (1 3 3 1)
                      (1 4 6 4 1))))
        (is (equal result (pascals-triangle:rows count)))))

(test six-rows
      (let ((count 6)
            (result '((1)
                      (1 1)
                      (1 2 1)
                      (1 3 3 1)
                      (1 4 6 4 1)
                      (1 5 10 10 5 1))))
        (is (equal result (pascals-triangle:rows count)))))

(test ten-rows
      (let ((count 10)
            (result '((1)
                      (1 1)
                      (1 2 1)
                      (1 3 3 1)
                      (1 4 6 4 1)
                      (1 5 10 10 5 1)
                      (1 6 15 20 15 6 1)
                      (1 7 21 35 35 21 7 1)
                      (1 8 28 56 70 56 28 8 1)
                      (1 9 36 84 126 126 84 36 9 1))))
        (is (equal result (pascals-triangle:rows count)))))

(test negative-rows 
      (let ((count -1))
        (is (equal 'nil (pascals-triangle:rows count)))))

(defun run-tests (&optional (test-or-suite 'pascals-triangle-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
