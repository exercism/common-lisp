(ql:quickload "lisp-unit")

(defpackage #:prime-factors-test
  (:use #:common-lisp #:lisp-unit))

#-xlisp-test (load "prime-factors")

(in-package #:prime-factors-test)

(define-test one
  (assert-equal '() (prime-factors:factors-of 1)))

(define-test two
  (assert-equal '(2) (prime-factors:factors-of 2)))

(define-test three
  (assert-equal '(3) (prime-factors:factors-of 3)))

(define-test four
  (assert-equal '(2 2) (prime-factors:factors-of 4)))

(define-test six
  (assert-equal '(2 3) (sort (prime-factors:factors-of 6) #'<)))

(define-test eight
  (assert-equal '(2 2 2) (prime-factors:factors-of 8)))

(define-test nine
  (assert-equal '(3 3) (prime-factors:factors-of 9)))

(define-test twenty-seven
  (assert-equal '(3 3 3) (prime-factors:factors-of 27)))

(define-test six-hundred-twenty-five
  (assert-equal '(5 5 5 5) (prime-factors:factors-of 625)))

(define-test a-large-number
  (assert-equal '(5 17 23 461)
                (sort (prime-factors:factors-of 901255) #'<)))

(define-test a-huge-number
  (assert-equal '(11 9539 894119)
                (sort (prime-factors:factors-of 93819012551) #'<)))

(define-test triple-squares-number
  (assert-equal '(2 2 5 5 7 7)
                (sort (prime-factors:factors-of 4900) #'<)))

(define-test mersenne-composite-1
  (assert-equal '(23 89)
                (sort (prime-factors:factors-of 2047) #'<)))

(define-test fermat-composite-1
  (assert-equal '(641 6700417)
                (sort (prime-factors:factors-of 4294967297) #'<)))

(define-test weak-probable-prime
  (assert-equal '(11 31)
                (sort (prime-factors:factors-of 341) #'<)))

(define-test strong-probable-prime
  (assert-equal '(7 31 73)
                (sort (prime-factors:factors-of 15841) #'<)))

(define-test carmichael-small-1
  (assert-equal '(3 11 17)
                (sort (prime-factors:factors-of 561) #'<)))

(define-test carmichael-small-2
  (assert-equal '(11 13 17 31)
                (sort (prime-factors:factors-of 75361) #'<)))

(define-test pseudoprime-smallish
  (assert-equal '(1303 16927 157543)
                (sort (prime-factors:factors-of 3474749660383) #'<)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :prime-factors-test))
