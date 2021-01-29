(ql:quickload "lisp-unit")
#-xlisp-test (load "hamming")

(defpackage #:hamming-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:hamming-test)

(define-test no-difference-between-empty-strands
  (assert-equal 0 (hamming:distance "" "")))

(define-test no-difference-between-identical-strands
  (assert-equal 0 (hamming:distance "GGACTGA" "GGACTGA")))

(define-test complete-hamming-distance-in-small-strand
  (assert-equal 3 (hamming:distance "ACT" "GGA")))

(define-test small-hamming-distance-in-middle-somewhere
  (assert-equal 1 (hamming:distance "GGACG" "GGTCG")))

(define-test larger-distance
  (assert-equal 2 (hamming:distance "ACCAGGG" "ACTATGG")))

(define-test invalid-to-get-distance-for-different-length-strings
  (assert-equal nil (hamming:distance "AGACAACAGCCAGCCGCCGGATT" "AGGCAA"))
  (assert-equal nil (hamming:distance "AGACAACAGCCAGCCGCCGGATT" "AGACATCTTTCAGCCGCCGGATTAGGCAA"))
  (assert-equal nil (hamming:distance "AGG" "AGACAACAGCCAGCCGCCGGATT")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :hamming-test))
