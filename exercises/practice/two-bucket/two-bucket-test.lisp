;; Ensures that two-bucket.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "two-bucket")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from two-bucket and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :two-bucket-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :two-bucket-test)

;; Define and enter a new FiveAM test-suite
(def-suite* two-bucket-suite)

(defun equal-alists (alist-one alist-two)
  (and (subsetp alist-one alist-two :test 'equal)
       (subsetp alist-two alist-one :test 'equal)))

(test measure-using-bucket-one-of-size-3-and-bucket-two-of-size-5-start-with-bucket-one
    (let* ((bucket-one 3)
           (bucket-two 5)
           (goal 1)
           (start-bucket :one)
           (result '((:moves . 4) (:goal-bucket . :one) (:other-bucket . 5)))
           (output (two-bucket:measure bucket-one bucket-two goal start-bucket)))
     (is (equal-alists result output))))

(test measure-using-bucket-one-of-size-3-and-bucket-two-of-size-5-start-with-bucket-two
    (let* ((bucket-one 3)
           (bucket-two 5)
           (goal 1)
           (start-bucket :two)
           (result '((:moves . 8) (:goal-bucket . :two) (:other-bucket . 3)))
           (output (two-bucket:measure bucket-one bucket-two goal start-bucket)))
     (is (equal-alists result output))))

(test measure-using-bucket-one-of-size-7-and-bucket-two-of-size-11-start-with-bucket-one
    (let* ((bucket-one 7)
           (bucket-two 11)
           (goal 2)
           (start-bucket :one)
           (result '((:moves . 14) (:goal-bucket . :one) (:other-bucket . 11)))
           (output (two-bucket:measure bucket-one bucket-two goal start-bucket)))
     (is (equal-alists result output))))

(test measure-using-bucket-one-of-size-7-and-bucket-two-of-size-11-start-with-bucket-two
    (let* ((bucket-one 7)
           (bucket-two 11)
           (goal 2)
           (start-bucket :two)
           (result '((:moves . 18) (:goal-bucket . :two) (:other-bucket . 7)))
           (output (two-bucket:measure bucket-one bucket-two goal start-bucket)))
     (is (equal-alists result output))))

(test measure-one-step-using-bucket-one-of-size-1-and-bucket-two-of-size-3-start-with-bucket-two
    (let* ((bucket-one 1)
           (bucket-two 3)
           (goal 3)
           (start-bucket :two)
           (result '((:moves . 1) (:goal-bucket . :two) (:other-bucket . 0)))
           (output (two-bucket:measure bucket-one bucket-two goal start-bucket)))
     (is (equal-alists result output))))

(test measure-using-bucket-one-of-size-2-and-bucket-two-of-size-3-start-with-bucket-one-and-end-with-bucket-two
    (let* ((bucket-one 2)
           (bucket-two 3)
           (goal 3)
           (start-bucket :one)
           (result '((:moves . 2) (:goal-bucket . :two) (:other-bucket . 2)))
           (output (two-bucket:measure bucket-one bucket-two goal start-bucket)))
     (is (equal-alists result output))))

(test not-possible-to-reach-the-goal
    (let ((bucket-one 6)
          (bucket-two 15)
          (goal 5)
          (start-bucket :one))
     (is (equal NIL (two-bucket:measure bucket-one bucket-two goal start-bucket)))))

(test with-the-same-buckets-but-a-different-goal-then-it-is-possible
    (let* ((bucket-one 6)
           (bucket-two 15)
           (goal 9)
           (start-bucket :one)
           (result '((:moves . 10) (:goal-bucket . :two) (:other-bucket . 0)))
           (output (two-bucket:measure bucket-one bucket-two goal start-bucket)))
     (is (equal-alists result output))))

(test goal-larger-than-both-buckets-is-impossible
    (let ((bucket-one 5)
          (bucket-two 7)
          (goal 8)
          (start-bucket :one))
     (is (equal NIL (two-bucket:measure bucket-one bucket-two goal start-bucket)))))

(defun run-tests (&optional (test-or-suite 'two-bucket-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
