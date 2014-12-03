(ql:quickload "lisp-unit")

(defpackage :rna-transcription-test
  (:use #:common-lisp #:lisp-unit))

(load "dna")

(in-package #:rna-transcription-test)

(define-test transcribes-cytidine-to-guanosine
  (assert-equal "G" (dna:to-rna "C")))

(define-test transcribes-guanosine-to-cytidine
  (assert-equal "C" (dna:to-rna "G")))

(define-test transcribes-adenosine-to-uracile
  (assert-equal "U" (dna:to-rna "A")))

(define-test it-transcribes-thymidine-to-adenosine
  (assert-equal "A" (dna:to-rna "T")))

(define-test it-transcribes-all-nucleotides
  (assert-equal "UGCACCAGAAUU" (dna:to-rna "ACGTGGTCTTAA")))

(define-test it-validates-dna-strands
  (assert-error 'error (dna:to-rna "XCGFGGTDTTAA")))

(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :rna-transcription-test))
