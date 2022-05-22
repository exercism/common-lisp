;; Ensures that knapsack.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "knapsack")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from knapsack and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :knapsack-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :knapsack-test)

;; Define and enter a new FiveAM test-suite
(def-suite* knapsack-suite)

(test no-items
    (let ((maximum-weight 100)
          (items '()))
      (is (= 0 (knapsack:maximum-value maximum-weight items)))))

(test one-item-too-heavy
    (let ((maximum-weight 10)
          (items '(((:weight . 100) (:value . 1)))))
      (is (= 0 (knapsack:maximum-value maximum-weight items)))))

(test five-items-cannot-be-greedy-by-weight
    (let ((maximum-weight 10)
          (items '(((:weight . 2) (:value . 5))
                   ((:weight . 2) (:value . 5))
                   ((:weight . 2) (:value . 5))
                   ((:weight . 2) (:value . 5))
                   ((:weight . 10) (:value . 21)))))
      (is (= 21 (knapsack:maximum-value maximum-weight items)))))

(test five-items-cannot-be-greedy-by-value
    (let ((maximum-weight 10)
          (items '(((:weight . 2) (:value . 20))
                   ((:weight . 2) (:value . 20))
                   ((:weight . 2) (:value . 20))
                   ((:weight . 2) (:value . 20))
                   ((:weight . 10) (:value . 50)))))
      (is (= 80 (knapsack:maximum-value maximum-weight items)))))

(test example-knapsack
    (let ((maximum-weight 10)
          (items '(((:weight . 5) (:value . 10))
                   ((:weight . 4) (:value . 40))
                   ((:weight . 6) (:value . 30))
                   ((:weight . 4) (:value . 50)))))
      (is (= 90 (knapsack:maximum-value maximum-weight items)))))

(test 8-items
    (let ((maximum-weight 104)
          (items '(((:weight . 25) (:value . 350))
                   ((:weight . 35) (:value . 400))
                   ((:weight . 45) (:value . 450))
                   ((:weight . 5) (:value . 20))
                   ((:weight . 25) (:value . 70))
                   ((:weight . 3) (:value . 8))
                   ((:weight . 2) (:value . 5))
                   ((:weight . 2) (:value . 5)))))
      (is (= 900 (knapsack:maximum-value maximum-weight items)))))

(test 15-items
    (let ((maximum-weight 750)
          (items '(((:weight . 70) (:value . 135))
                   ((:weight . 73) (:value . 139))
                   ((:weight . 77) (:value . 149))
                   ((:weight . 80) (:value . 150))
                   ((:weight . 82) (:value . 156))
                   ((:weight . 87) (:value . 163))
                   ((:weight . 90) (:value . 173))
                   ((:weight . 94) (:value . 184))
                   ((:weight . 98) (:value . 192))
                   ((:weight . 106) (:value . 201))
                   ((:weight . 110) (:value . 210))
                   ((:weight . 113) (:value . 214))
                   ((:weight . 115) (:value . 221))
                   ((:weight . 118) (:value . 229))
                   ((:weight . 120) (:value . 240)))))
      (is (= 1458 (knapsack:maximum-value maximum-weight items)))))

(defun run-tests (&optional (test-or-suite 'knapsack-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
