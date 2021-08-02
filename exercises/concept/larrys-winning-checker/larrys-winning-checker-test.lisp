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

(test left-and-right
  (is (equalp (left-and-right #2A((X O X) (O X O) (X X O)) 1 1)
             #(O X O)))
  (is (equalp (left-and-right #2A((X O X) (O X O) (X X O)) 0 1)
             #(X O X)))
  (is (equalp (left-and-right #2A((X O X) (O X O) (X X O)) 2 1)
             #(X X O))))

(test out-of-bounds-left-right
  (is (equalp (left-and-right #2A((X O X) (O X O) (X X O)) 0 0)
             #(NIL X O)))
  (is (equalp (left-and-right #2A((X O X) (O X O) (X X O)) 2 2)
             #(X O NIL)))
  (is (equalp (left-and-right #2A((X O X) (O X O) (X X O)) 13 13)
             #(NIL NIL NIL))))

(test above-and-below
  (is (equalp (above-and-below #2A((X O X) (O X O) (X X O)) 1 1 )
             #(O X X)))
  (is (equalp (above-and-below #2A((X O X) (O X O) (X X O)) 1 0)
             #(X O X)))
  (is (equalp (above-and-below #2A((X O X) (O X O) (X X O)) 1 2)
             #(X O O))))

(test out-of-bounds-above-below
  (is (equalp (above-and-below #2A((X O X) (O X O) (X X O)) 0 0)
             #(NIL X O)))
  (is (equalp (above-and-below #2A((X O X) (O X O) (X X O)) 2 2)
             #(O O NIL)))
  (is (equalp (above-and-below #2A((X O X) (O X O) (X X O)) 13 13)
             #(NIL NIL NIL))))

(defun run-tests (&optional (test-or-suite 'larrys-winning-checker-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
