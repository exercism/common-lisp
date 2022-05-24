;; Ensures that saddle-points.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "saddle-points")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from saddle-points and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :saddle-points-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :saddle-points-test)

;; Define and enter a new FiveAM test-suite
(def-suite* saddle-points-suite)

(defun equal-coordinates (alist-one alist-two)
  (and (subsetp alist-one alist-two :test 'equal)
       (subsetp alist-two alist-one :test 'equal)))

(test can-identify-single-saddle-point
    (let ((matrix #2A((9 8 7)
                      (5 3 2)
                      (6 6 7)))
          (result '((2 1))))
      (is (equal-coordinates result (saddle-points:saddle-points matrix)))))

(test can-identify-that-empty-matrix-has-no-saddle-points
    (let ((matrix #2A(()))
          (result '()))
      (is (equal-coordinates result (saddle-points:saddle-points matrix)))))

(test can-identify-lack-of-saddle-points-when-there-are-none
    (let ((matrix #2A((1 2 3)
                      (3 1 2)
                      (2 3 1)))
          (result '()))
      (is (equal-coordinates result (saddle-points:saddle-points matrix)))))

(test can-identify-multiple-saddle-points-in-a-column
    (let ((matrix #2A((4 5 4)
                      (3 5 5)
                      (1 5 4)))
          (result '((1 2) (2 2) (3 2))))
      (is (equal-coordinates result (saddle-points:saddle-points matrix)))))

(test can-identify-multiple-saddle-points-in-a-row
    (let ((matrix #2A((6 7 8)
                      (5 5 5)
                      (7 5 6)))
          (result '((2 1) (2 2) (2 3))))
      (is (equal-coordinates result (saddle-points:saddle-points matrix)))))

(test can-identify-saddle-point-in-bottom-right-corner
    (let ((matrix #2A((8 7 9)
                      (6 7 6)
                      (3 2 5)))
          (result '((3 3))))
      (is (equal-coordinates result (saddle-points:saddle-points matrix)))))

(test can-identify-saddle-points-in-a-non-square-matrix
    (let ((matrix #2A((3 1 3)
                      (3 2 4)))
          (result '((1 3) (1 1))))
      (is (equal-coordinates result (saddle-points:saddle-points matrix)))))

(test can-identify-that-saddle-points-in-a-single-column-matrix-are-those-with-the-minimum-value
    (let ((matrix #2A((2)
                      (1)
                      (4)
                      (1)))
          (result '((2 1) (4 1))))
      (is (equal-coordinates result (saddle-points:saddle-points matrix)))))

(test can-identify-that-saddle-points-in-a-single-row-matrix-are-those-with-the-maximum-value
    (let ((matrix #2A((2 5 3 5)))
          (result '((1 2) (1 4))))
      (is (equal-coordinates result (saddle-points:saddle-points matrix)))))

(defun run-tests (&optional (test-or-suite 'saddle-points-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
