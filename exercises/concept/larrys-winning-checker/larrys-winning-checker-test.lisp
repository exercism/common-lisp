;; Ensures that larrys-winning-checker.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "larrys-winning-checker")
  (ql:quickload :fiveam))

;; Defines the testing package with symbols from larrys-winning-checker and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :larrys-winning-checker-test
  (:use :cl :fiveam :larrys-winning-checker)
  (:export :run-tests))

;; Enter the testing package
(in-package :larrys-winning-checker-test)

(def-suite larrys-winning-checker-suite)
(in-suite larrys-winning-checker-suite)

(test make-a-board
  (is (equalp #2A((NIL NIL NIL) (NIL NIL NIL) (NIL NIL NIL)) (make-empty-board)))
  (is (equalp #2A((O X O) (X O X) (X X O))
              (make-board-from-list '((O X O) (X O X) (X X O))))))

(test winning
  (is (all-the-same-p #(X X X)))
  (is (all-the-same-p #(O O O)))
  (is (not (all-the-same-p #(X O X)))))

(test row
  (is (row #2A((X O X) (O X O) (X X O)) 0) #(X O X))
  (is (row #2A((X O X) (O X O) (X X O)) 1) #(O X O))
  (is (row #2A((X O X) (O X O) (X X O)) 2) #(X X O)))

(test column
  (is (column #2A((X O X) (O X O) (X X O)) 0) #(X O X))
  (is (column #2A((X O X) (O X O) (X X O)) 1) #(O X X))
  (is (column #2A((X O X) (O X O) (X X O)) 2) #(X O O)))

(defun run-tests (&optional (test-or-suite 'larrys-winning-checker-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
