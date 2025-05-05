;; Ensures that hamming.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "hamming")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from hamming and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :hamming-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :hamming-test)

;; Define and enter a new FiveAM test-suite
(def-suite* hamming-suite)

(test empty-strands
    (let ((strand1 "")
          (strand2 ""))
      (is (= 0 (hamming:distance strand1 strand2)))))

(test single-letter-identical-strands
    (let ((strand1 "A")
          (strand2 "A"))
      (is (= 0 (hamming:distance strand1 strand2)))))

(test single-letter-different-strands
    (let ((strand1 "G")
          (strand2 "T"))
      (is (= 1 (hamming:distance strand1 strand2)))))

(test long-identical-strands
    (let ((strand1 "GGACTGAAATCTG")
          (strand2 "GGACTGAAATCTG"))
      (is (= 0 (hamming:distance strand1 strand2)))))

(test long-different-strands
    (let ((strand1 "GGACGGATTCTG")
          (strand2 "AGGACGGATTCT"))
      (is (= 9 (hamming:distance strand1 strand2)))))

(test disallow-first-strand-longer
    (let ((strand1 "AATG")
          (strand2 "AAA"))
      (is (equal NIL (hamming:distance strand1 strand2)))))

(test disallow-second-strand-longer
    (let ((strand1 "ATA")
          (strand2 "AGTG"))
      (is (equal NIL (hamming:distance strand1 strand2)))))

(test disallow-empty-first-strand
    (let ((strand1 "")
          (strand2 "G"))
      (is (equal NIL (hamming:distance strand1 strand2)))))

(test disallow-empty-second-strand
    (let ((strand1 "G")
          (strand2 ""))
      (is (equal NIL (hamming:distance strand1 strand2)))))

(defun run-tests (&optional (test-or-suite 'hamming-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
