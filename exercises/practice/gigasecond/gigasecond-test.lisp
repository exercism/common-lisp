(ql:quickload "lisp-unit")
#-xlisp-test (load "gigasecond")

(defpackage #:gigasecond-test
  (:use #:cl #:lisp-unit))

(in-package #:gigasecond-test)

(define-test from-lisp-epoch
  (assert-equal '(1931 9 10 1 46 40) (gigasecond:from 1900 1 1 0 0 0)))

(define-test from-unix-epoch
  (assert-equal '(2001 9 9 1 46 40) (gigasecond:from 1970 1 1 0 0 0)))

(define-test from-20110425T120000Z
  (assert-equal '(2043 1 1 13 46 40) (gigasecond:from 2011 4 25 12 0 0)))

(define-test from-19770613T235959Z
  (assert-equal '(2009 2 20 1 46 39) (gigasecond:from 1977 6 13 23 59 59)))

(define-test from-19590719T123030Z
  (assert-equal '(1991 3 27 14 17 10) (gigasecond:from 1959 7 19 12 30 30)))

; customize this to test your birthday and find your gigasecond date:
; (define-test your-birthday
;   (assert-equal '(year2 month2 day2) (gigasecond:from year1 month1 day1)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :gigasecond-test))
