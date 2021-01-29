(ql:quickload "lisp-unit")
#-xlisp-test (load "rna-transcription")

(defpackage :rna-transcription-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:rna-transcription-test)

(define-test transcribes-cytidine-to-guanosine
  (assert-equal "G" (rna-transcription:to-rna "C")))

(define-test transcribes-guanosine-to-cytidine
  (assert-equal "C" (rna-transcription:to-rna "G")))

(define-test transcribes-adenosine-to-uracile
  (assert-equal "U" (rna-transcription:to-rna "A")))

(define-test it-transcribes-thymidine-to-adenosine
  (assert-equal "A" (rna-transcription:to-rna "T")))

(define-test it-transcribes-all-nucleotides
  (assert-equal "UGCACCAGAAUU" (rna-transcription:to-rna "ACGTGGTCTTAA")))

(define-test it-validates-dna-strands
  (assert-error 'error (rna-transcription:to-rna "XCGFGGTDTTAA")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :rna-transcription-test))
