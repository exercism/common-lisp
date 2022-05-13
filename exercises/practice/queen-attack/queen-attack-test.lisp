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
    (let ((coordinates '((:row . 2) (:column . 2))))
      (is (equalp #S(queen-attack:queen :row 2 :column 2) (queen-attack:create coordinates)))))

(test queen-must-have-positive-row
    (let ((coordinates '((:row . -2) (:column . 2))))
      (is (eql NIL (queen-attack:create coordinates)))))

(test queen-must-have-row-on-board
    (let ((coordinates '((:row . 8) (:column . 4))))
      (is (eql NIL (queen-attack:create coordinates)))))

(test queen-must-have-positive-column
    (let ((coordinates '((:row . 2) (:column . -2))))
      (is (eql NIL (queen-attack:create coordinates)))))

(test queen-must-have-column-on-board
    (let ((coordinates '((:row . 4) (:column . 8))))
      (is (eql NIL (queen-attack:create coordinates)))))

(test cannot-attack
    (let ((white-queen (queen-attack:create '((:row . 2) (:column . 4))))
          (black-queen (queen-attack:create '((:row . 6) (:column . 6)))))
      (is-false (queen-attack:attackp white-queen black-queen))))

(test can-attack-on-same-row
    (let ((white-queen (queen-attack:create '((:row . 2) (:column . 4))))
          (black-queen (queen-attack:create '((:row . 2) (:column . 6)))))
      (is-true (queen-attack:attackp white-queen black-queen))))

(test can-attack-on-same-column
    (let ((white-queen (queen-attack:create '((:row . 4) (:column . 5))))
          (black-queen (queen-attack:create '((:row . 2) (:column . 5)))))
      (is-true (queen-attack:attackp white-queen black-queen))))

(test can-attack-on-first-diagonal
    (let ((white-queen (queen-attack:create '((:row . 2) (:column . 2))))
          (black-queen (queen-attack:create '((:row . 0) (:column . 4)))))
      (is-true (queen-attack:attackp white-queen black-queen))))

(test can-attack-on-second-diagonal
    (let ((white-queen (queen-attack:create '((:row . 2) (:column . 2))))
          (black-queen (queen-attack:create '((:row . 3) (:column . 1)))))
      (is-true (queen-attack:attackp white-queen black-queen))))

(test can-attack-on-third-diagonal
    (let ((white-queen (queen-attack:create '((:row . 2) (:column . 2))))
          (black-queen (queen-attack:create '((:row . 1) (:column . 1)))))
      (is-true (queen-attack:attackp white-queen black-queen))))

(test can-attack-on-fourth-diagonal
    (let ((white-queen (queen-attack:create '((:row . 1) (:column . 7))))
          (black-queen (queen-attack:create '((:row . 0) (:column . 6)))))
      (is-true (queen-attack:attackp white-queen black-queen))))

(test cannot-attack-if-falling-diagonals-are-only-the-same-when-reflected-across-the-longest-falling-diagonal
    (let ((white-queen (queen-attack:create '((:row . 4) (:column . 1))))
          (black-queen (queen-attack:create '((:row . 2) (:column . 5)))))
      (is-false (queen-attack:attackp white-queen black-queen))))

(defun run-tests (&optional (test-or-suite 'queen-attack-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
