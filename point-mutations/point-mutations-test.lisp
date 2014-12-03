(ql:quickload "lisp-unit")

(defpackage #:point-mutations-test
  (:use #:common-lisp #:lisp-unit))

(load "dna")

(in-package #:point-mutations-test)

(define-test no-difference-between-empty-strands
  (assert-equal 0 (dna:hamming-distance "" "")))

(define-test no-difference-between-identical-strands
  (assert-equal 0 (dna:hamming-distance "GGACTGA" "GGACTGA")))

(define-test complete-hamming-distance-in-small-strand
  (assert-equal 3 (dna:hamming-distance "ACT" "GGA")))

(define-test small-hamming-distance-in-middle-somewhere
  (assert-equal 1 (dna:hamming-distance "GGACG" "GGTCG")))

(define-test larger-distance
  (assert-equal 2 (dna:hamming-distance "ACCAGGG" "ACTATGG")))

(define-test invalid-to-get-distance-for-different-length-strings
  (assert-equal nil (dna:hamming-distance "AGACAACAGCCAGCCGCCGGATT" "AGGCAA"))
  (assert-equal nil (dna:hamming-distance "AGACAACAGCCAGCCGCCGGATT" "AGACATCTTTCAGCCGCCGGATTAGGCAA"))
  (assert-equal nil (dna:hamming-distance "AGG" "AGACAACAGCCAGCCGCCGGATT")))

(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :point-mutations-test))
