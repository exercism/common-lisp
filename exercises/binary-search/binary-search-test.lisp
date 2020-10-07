(ql:quickload "lisp-unit")
#-xlisp-test (load "binary-search")

(defpackage #:binary-search-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:binary-search-test)

(define-test finds-a-value-in-an-array-with-one-element
  (assert-equal (binary-search:binary-find #(6) 6) 0))

(define-test finds-a-value-in-the-middle-of-an-array
  (assert-equal (binary-search:binary-find #(1 3 4 6 8 9 11) 6) 3))

(define-test finds-a-value-at-the-beginning-of-an-array
  (assert-equal (binary-search:binary-find #(1 3 4 6 8 9 11) 1) 0))

(define-test finds-a-value-at-the-end-of-an-array
  (assert-equal (binary-search:binary-find #(1 3 4 6 8 9 11) 11) 6))

(define-test finds-a-value-in-an-array-of-odd-length
  (assert-equal (binary-search:binary-find #(1 3 5 8 13 21 34 55 89 144 233 377 634) 144) 9))

(define-test finds-a-value-in-an-array-of-even-length
  (assert-equal (binary-search:binary-find #(1 3 5 8 13 21 34 55 89 144 233 377) 21) 5))

(define-test identifies-that-a-value-is-not-included-in-the-array
  (assert-equal (binary-search:binary-find #(1 3 4 6 8 9 11) 7) nil))

(define-test a-value-smaller-than-the-array-s-smallest-value-is-not-found
  (assert-equal (binary-search:binary-find #(1 3 4 6 8 9 11) 0) nil))

(define-test a-value-larger-than-the-array-s-largest-value-is-not-found
  (assert-equal (binary-search:binary-find #(1 3 4 6 8 9 11) 13) nil))

(define-test nothing-is-found-in-an-empty-array
  (assert-equal (binary-search:binary-find #() 1) nil))

(define-test nothing-is-found-when-the-left-and-right-bounds-cross
  (assert-equal (binary-search:binary-find #(1 2) 0) nil))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :binary-search-test))
