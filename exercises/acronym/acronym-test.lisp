(ql:quickload "lisp-unit")
#-xlisp-test (load "acronym")

(defpackage #:acronym-test
  (:use #:common-lisp #:lisp-unit #:acronym))

(in-package #:acronym-test)


(define-test empty-gives-empty
  (assert-equal
    ""
    (acronym "")))

(define-test png-test
  (assert-equal
    "PNG"
    (acronym "Portable Network Graphics")))

(define-test ror-test
  (assert-equal
    "ROR"
    (acronym "Ruby on Rails")))

(define-test html-test
  (assert-equal
    "HTML"
    (acronym "HyperText Markup Language")))

(define-test fifo-test
  (assert-equal
    "FIFO"
    (acronym "First In, First Out")))

(define-test php-test
  (assert-equal
    "PHP"
    (acronym "PHP: Hypertext Preprocessor")))

(define-test cmos-test
  (assert-equal
    "CMOS"
    (acronym "Complementary metal-oxide semiconductor")))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :acronym-test))
