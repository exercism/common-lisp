;; Ensures that queen-attack.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "queen-attack")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from queen-attack and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :queen-attack-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :queen-attack-test)

;; Define and enter a new FiveAM test-suite
(def-suite* queen-attack-suite)

(test queen-with-a-valid-position
    (let ((coordinates '(2 . 2)))
      (is-true (queen-attack:valid-position-p coordinates))))

(test queen-must-have-positive-row
    (let ((coordinates '(-2 . 2)))
      (is-false (queen-attack:valid-position-p coordinates))))

(test queen-must-have-row-on-board
    (let ((coordinates '(8 . 4)))
      (is-false (queen-attack:valid-position-p coordinates))))

(test queen-must-have-positive-column
    (let ((coordinates '(2 . -2)))
      (is-false (queen-attack:valid-position-p coordinates))))

(test queen-must-have-column-on-board
    (let ((coordinates '(4 . 8)))
      (is-false (queen-attack:valid-position-p coordinates))))

(test cannot-attack
    (let ((white-queen '(2 . 4))
          (black-queen '(6 . 6)))
      (is-false (queen-attack:attackp white-queen black-queen))))

(test can-attack-on-same-row
    (let ((white-queen '(2 . 4))
          (black-queen '(2 . 6)))
      (is-true (queen-attack:attackp white-queen black-queen))))

(test can-attack-on-same-column
    (let ((white-queen '(4 . 5))
          (black-queen '(2 . 5)))
      (is-true (queen-attack:attackp white-queen black-queen))))

(test can-attack-on-first-diagonal
    (let ((white-queen '(2 . 2))
          (black-queen '(0 . 4)))
      (is-true (queen-attack:attackp white-queen black-queen))))

(test can-attack-on-second-diagonal
    (let ((white-queen '(2 . 2))
          (black-queen '(3 . 1)))
      (is-true (queen-attack:attackp white-queen black-queen))))

(test can-attack-on-third-diagonal
    (let ((white-queen '(2 . 2))
          (black-queen '(1 . 1)))
      (is-true (queen-attack:attackp white-queen black-queen))))

(test can-attack-on-fourth-diagonal
    (let ((white-queen '(1 . 7))
          (black-queen '(0 . 6)))
      (is-true (queen-attack:attackp white-queen black-queen))))

(test cannot-attack-if-falling-diagonals-are-only-the-same-when-reflected-across-the-longest-falling-diagonal
    (let ((white-queen '(4 . 1))
          (black-queen '(2 . 5)))
      (is-false (queen-attack:attackp white-queen black-queen))))

(defun run-tests (&optional (test-or-suite 'queen-attack-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
