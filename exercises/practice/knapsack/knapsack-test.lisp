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
          (items (list)))
      (is (= 0 (knapsack:maximum-value maximum-weight items)))))

(test one-item-too-heavy
    (let ((maximum-weight 10)
          (items (list (list '(:weight . 100) '(:value . 1)))))
      (is (= 0 (knapsack:maximum-value maximum-weight items)))))

(test five-items-cannot-be-greedy-by-weight
    (let ((maximum-weight 10)
          (items (list (list '(:weight . 2) '(:value . 5))
                       (list '(:weight . 2) '(:value . 5))
                       (list '(:weight . 2) '(:value . 5))
                       (list '(:weight . 2) '(:value . 5))
                       (list '(:weight . 10) '(:value . 21)))))
      (is (= 21 (knapsack:maximum-value maximum-weight items)))))

(test five-items-cannot-be-greedy-by-value
    (let ((maximum-weight 10)
          (items (list (list '(:weight . 2) '(:value . 20))
                       (list '(:weight . 2) '(:value . 20))
                       (list '(:weight . 2) '(:value . 20))
                       (list '(:weight . 2) '(:value . 20))
                       (list '(:weight . 10) '(:value . 50)))))
      (is (= 80 (knapsack:maximum-value maximum-weight items)))))

(test example-knapsack
    (let ((maximum-weight 10)
          (items (list (list '(:weight . 5) '(:value . 10))
                       (list '(:weight . 4) '(:value . 40))
                       (list '(:weight . 6) '(:value . 30))
                       (list '(:weight . 4) '(:value . 50)))))
      (is (= 90 (knapsack:maximum-value maximum-weight items)))))

(test 8-items
    (let ((maximum-weight 104)
          (items (list (list '(:weight . 25) '(:value . 350))
                       (list '(:weight . 35) '(:value . 400))
                       (list '(:weight . 45) '(:value . 450))
                       (list '(:weight . 5) '(:value . 20))
                       (list '(:weight . 25) '(:value . 70))
                       (list '(:weight . 3) '(:value . 8))
                       (list '(:weight . 2) '(:value . 5))
                       (list '(:weight . 2) '(:value . 5)))))
      (is (= 900 (knapsack:maximum-value maximum-weight items)))))

(test 15-items
    (let ((maximum-weight 750)
          (items (list (list '(:weight . 70) '(:value . 135))
                       (list '(:weight . 73) '(:value . 139))
                       (list '(:weight . 77) '(:value . 149))
                       (list '(:weight . 80) '(:value . 150))
                       (list '(:weight . 82) '(:value . 156))
                       (list '(:weight . 87) '(:value . 163))
                       (list '(:weight . 90) '(:value . 173))
                       (list '(:weight . 94) '(:value . 184))
                       (list '(:weight . 98) '(:value . 192))
                       (list '(:weight . 106) '(:value . 201))
                       (list '(:weight . 110) '(:value . 210))
                       (list '(:weight . 113) '(:value . 214))
                       (list '(:weight . 115) '(:value . 221))
                       (list '(:weight . 118) '(:value . 229))
                       (list '(:weight . 120) '(:value . 240)))))
      (is (= 1458 (knapsack:maximum-value maximum-weight items)))))

(defun run-tests (&optional (test-or-suite 'knapsack-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
