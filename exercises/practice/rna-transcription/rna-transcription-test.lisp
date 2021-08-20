;; Ensures that rna-transcription.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "rna-transcription")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from rna-transcription and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :rna-transcription-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :rna-transcription-test)

;; Define and enter a new FiveAM test-suite
(def-suite* rna-transcription-suite)

(test transcribes-cytidine-to-guanosine
 (is (equal "G" (rna-transcription:to-rna "C"))))

(test transcribes-guanosine-to-cytidine
 (is (equal "C" (rna-transcription:to-rna "G"))))

(test transcribes-adenosine-to-uracile
 (is (equal "U" (rna-transcription:to-rna "A"))))

(test it-transcribes-thymidine-to-adenosine
 (is (equal "A" (rna-transcription:to-rna "T"))))

(test it-transcribes-all-nucleotides
 (is (equal "UGCACCAGAAUU" (rna-transcription:to-rna "ACGTGGTCTTAA"))))

(test it-validates-dna-strands
 (signals error (rna-transcription:to-rna "XCGFGGTDTTAA")))

(defun run-tests (&optional (test-or-suite 'rna-transcription-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
