;; Ensures that nucleotide-count.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "nucleotide-count")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from nucleotide-count and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :nucleotide-count-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :nucleotide-count-test)

;; Define and enter a new FiveAM test-suite
(def-suite* nucleotide-count-suite)

(defun make-hash (kvs)
  (reduce #'(lambda (h kv) (setf (gethash (first kv) h) (second kv)) h) kvs
          :initial-value (make-hash-table)))

(test empty-dna-strand-has-no-adenine
 (is (equal 0 (nucleotide-count:dna-count #\A ""))))

(test empty-dna-strand-has-no-nucleotides
 (is
  (equalp (make-hash '((#\A 0) (#\T 0) (#\C 0) (#\G 0)))
          (nucleotide-count:nucleotide-counts ""))))

(test repetitive-cytosine-gets-counted
 (is (equal 5 (nucleotide-count:dna-count #\C "CCCCC"))))

(test repetitive-sequence-has-only-guanine
 (is
  (equalp (make-hash '((#\A 0) (#\T 0) (#\C 0) (#\G 8)))
          (nucleotide-count:nucleotide-counts "GGGGGGGG"))))

(test counts-only-thymine
 (is (equal 1 (nucleotide-count:dna-count #\T "GGGGGTAACCCGG"))))

(test validates-nucleotides
 (signals nucleotide-count:invalid-nucleotide
  (nucleotide-count:dna-count #\X "GACT")))

(test counts-all-nucleotides
 (is
  (equalp (make-hash '((#\A 20) (#\T 21) (#\G 17) (#\C 12)))
          (nucleotide-count:nucleotide-counts
           "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"))))

(defun run-tests (&optional (test-or-suite 'nucleotide-count-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
