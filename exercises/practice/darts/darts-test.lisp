;; Ensures that darts.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "darts")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from darts and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :darts-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :darts-test)

;; Define and enter a new FiveAM test-suite
(def-suite* darts-suite)

(test missed-target
    (let ((x -9)
          (y 9))
      (is (= 0 (darts:score x y)))))

(test on-the-outer-circle
    (let ((x 0)
          (y 10))
      (is (= 1 (darts:score x y)))))

(test on-the-middle-circle
    (let ((x -5)
          (y 0))
      (is (= 5 (darts:score x y)))))

(test on-the-inner-circle
    (let ((x 0)
          (y -1))
      (is (= 10 (darts:score x y)))))

(test exactly-on-centre
    (let ((x 0)
          (y 0))
      (is (= 10 (darts:score x y)))))

(test near-the-centre
    (let ((x -0.1)
          (y -0.1))
      (is (= 10 (darts:score x y)))))

(test just-within-the-inner-circle
    (let ((x 0.7)
          (y 0.7))
      (is (= 10 (darts:score x y)))))

(test just-outside-the-inner-circle
    (let ((x 0.8)
          (y -0.8))
      (is (= 5 (darts:score x y)))))

(test just-within-the-middle-circle
    (let ((x -3.5)
          (y 3.5))
      (is (= 5 (darts:score x y)))))

(test just-outside-the-middle-circle
    (let ((x -3.6)
          (y -3.6))
      (is (= 1 (darts:score x y)))))

(test just-within-the-outer-circle
    (let ((x -7.0)
          (y 7.0))
      (is (= 1 (darts:score x y)))))

(test just-outside-the-outer-circle
    (let ((x 7.1)
          (y -7.1))
      (is (= 0 (darts:score x y)))))

(test asymmetric-position-between-the-inner-and-middle-circles
    (let ((x 0.5)
          (y -4))
      (is (= 5 (darts:score x y)))))

(defun run-tests (&optional (test-or-suite 'darts-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
