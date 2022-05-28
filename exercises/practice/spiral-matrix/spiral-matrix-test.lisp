;; Ensures that spiral-matrix.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "spiral-matrix")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from spiral-matrix and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :spiral-matrix-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :spiral-matrix-test)

;; Define and enter a new FiveAM test-suite
(def-suite* spiral-matrix-suite)

(test empty-spiral
    (let ((size 0))
      (is (eql NIL (spiral-matrix:spiral-matrix size)))))

(test trivial-spiral
    (let ((size 1)
          (result #2A((1))))
      (is (equalp result (spiral-matrix:spiral-matrix size)))))

(test spiral-of-size-2
    (let ((size 2)
          (result #2A((1 2)
                      (4 3))))
      (is (equalp result (spiral-matrix:spiral-matrix size)))))

(test spiral-of-size-3
    (let ((size 3)
          (result #2A((1 2 3)
                      (8 9 4)
                      (7 6 5))))
      (is (equalp result (spiral-matrix:spiral-matrix size)))))

(test spiral-of-size-4
    (let ((size 4)
          (result #2A((1 2 3 4)
                      (12 13 14 5)
                      (11 16 15 6)
                      (10 9 8 7))))
      (is (equalp result (spiral-matrix:spiral-matrix size)))))

(test spiral-of-size-5
    (let ((size 5)
          (result #2A((1 2 3 4 5)
                      (16 17 18 19 6)
                      (15 24 25 20 7)
                      (14 23 22 21 8)
                      (13 12 11 10 9))))
      (is (equalp result (spiral-matrix:spiral-matrix size)))))

(defun run-tests (&optional (test-or-suite 'spiral-matrix-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
