(ql:quickload "lisp-unit")
#-xlisp-test (load "acronym")

(defpackage #:acronym-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:acronym-test)


(define-test empty-gives-empty
  (assert-equal
    ""
    (acronym:acronym "")))

(define-test png-test
  (assert-equal
    "PNG"
    (acronym:acronym "Portable Network Graphics")))

(define-test ror-test
  (assert-equal
    "ROR"
    (acronym:acronym "Ruby on Rails")))

(define-test fifo-test
  (assert-equal
    "FIFO"
    (acronym:acronym "First In, First Out")))

(define-test php-test
  (assert-equal
    "PHP"
    (acronym:acronym "PHP: Hypertext Preprocessor")))

(define-test cmos-test
  (assert-equal
    "CMOS"
    (acronym:acronym "Complementary metal-oxide semiconductor")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :acronym-test))
