;; Ensures that etl.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "etl")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from etl and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage #:etl-test
  (:use #:cl #:fiveam)
  (:export #:run-tests))

;; Enter the testing package
(in-package #:etl-test)

;; Define and enter a new FiveAM test-suite
(def-suite* etl-suite)

(defun make-hash (kvs)
  (reduce #'(lambda (h kv) (setf (gethash (first kv) h) (second kv)) h) kvs
          :initial-value (make-hash-table :test 'equalp)))

(test transform-one-value
 (is
  (equalp (make-hash '(("world" 1)))
          (etl:transform (make-hash '((1 ("WORLD"))))))))

(test transform-more-values
 (is
  (equalp (make-hash '(("world" 1) ("gschoolers" 1)))
          (etl:transform (make-hash '((1 ("WORLD" "GSCHOOLERS"))))))))

(test more-keys
 (is
  (equalp (make-hash '(("apple" 1) ("artichoke" 1) ("boat" 2) ("ballerina" 2)))
          (etl:transform
           (make-hash '((1 ("APPLE" "ARTICHOKE")) (2 ("BOAT" "BALLERINA"))))))))

(test full-dataset
 (let ((input-data
        '((1 ("A" "E" "I" "O" "U" "L" "N" "R" "S" "T")) (2 ("D" "G"))
          (3 ("B" "C" "M" "P")) (4 ("F" "H" "V" "W" "Y")) (5 ("K"))
          (8 ("J" "X")) (10 ("Q" "Z"))))
       (expected-output
        '(("a" 1) ("b" 3) ("c" 3) ("d" 2) ("e" 1) ("f" 4) ("g" 2) ("h" 4)
          ("i" 1) ("j" 8) ("k" 5) ("l" 1) ("m" 3) ("n" 1) ("o" 1) ("p" 3)
          ("q" 10) ("r" 1) ("s" 1) ("t" 1) ("u" 1) ("v" 4) ("w" 4) ("x" 8)
          ("y" 4) ("z" 10))))
   (is
    (equalp (make-hash expected-output)
            (etl:transform (make-hash input-data))))))

(defun run-tests (&optional (test-or-suite 'etl-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
