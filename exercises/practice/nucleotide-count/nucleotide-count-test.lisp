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

(test empty-strand
    (let ((strand "")
          (result '((#\A . 0) (#\C . 0) (#\G . 0) (#\T . 0))))
      (is (equal result (nucleotide-count:nucleotide-counts strand)))))

(test can-count-one-nucleotide-in-single-character-input
    (let ((strand "G")
          (result '((#\A . 0) (#\C . 0) (#\G . 1) (#\T . 0))))
      (is (equal result (nucleotide-count:nucleotide-counts strand)))))

(test strand-with-repeated-nucleotide
    (let ((strand "GGGGGGG")
          (result '((#\A . 0) (#\C . 0) (#\G . 7) (#\T . 0))))
      (is (equal result (nucleotide-count:nucleotide-counts strand)))))

(test strand-with-multiple-nucleotides
    (let ((strand "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC")
          (result '((#\A . 20) (#\C . 12) (#\G . 17) (#\T . 21))))
      (is (equal result (nucleotide-count:nucleotide-counts strand)))))

(test strand-with-invalid-nucleotides
    (let ((strand "AGXXACT"))
      (is (equal NIL (nucleotide-count:nucleotide-counts strand)))))

(defun run-tests (&optional (test-or-suite 'nucleotide-count-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
