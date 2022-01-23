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

(test no-difference-between-empty-strands
 (is (equal 0 (hamming:distance "" ""))))

(test no-difference-between-identical-strands
 (is (equal 0 (hamming:distance "GGACTGA" "GGACTGA"))))

(test complete-hamming-distance-in-small-strand
 (is (equal 3 (hamming:distance "ACT" "GGA"))))

(test small-hamming-distance-in-middle-somewhere
 (is (equal 1 (hamming:distance "GGACG" "GGTCG"))))

(test larger-distance (is (equal 2 (hamming:distance "ACCAGGG" "ACTATGG"))))

(test invalid-to-get-distance-for-different-length-strings
 (is (equal nil (hamming:distance "AATG" "AAA")))
 (is
  (equal nil
         (hamming:distance "ATA"
                           "AGTG"))))

(test invalid-empty-strands
  (is (equal nil (hamming:distance "" "G")))
  (is (equal nil (hamming:distance "G" ""))))

(defun run-tests (&optional (test-or-suite 'hamming-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
