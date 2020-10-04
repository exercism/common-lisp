(ql:quickload "lisp-unit")
#-xlisp-test (load "accumulate")

(defpackage #:accumulate-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:accumulate-test)

(define-test test-empty-sequence
  (assert-equal (accumulate '() #'(lambda (x) (/ x 2))) '()))

(define-test test-pow
  (assert-equal (accumulate '(1 2 3 4 5) #'(lambda (x) (* x x)))
		'(1 4 9 16 25)))

(define-test test-divmod
  (assert-equal (accumulate '(10 17 23) #'(lambda (x) (multiple-value-list (truncate x 7))))
		'((1 3) (2 3) (3 2))))

(define-test test-composition
  (let ((input '(10 17 23)))
    (assert-equal (accumulate (accumulate input
					  #'(lambda (x) (multiple-value-list (truncate x 7))))
			      #'(lambda (x) (+ (* 7 (car x)) (cadr x))))
		  input)))

(define-test test-capitalize
  (assert-equal (accumulate '("hello" "world") #'string-upcase)
		'("HELLO" "WORLD")))

(define-test test-recursive
  (let ((input '("a" "b" "c"))
	(output '(("a1" "a2" "a3") ("b1" "b2" "b3") ("c1" "c2" "c3"))))
    (assert-equal (accumulate input
			      #'(lambda (x) (accumulate '("1" "2" "3")
							#'(lambda (y) (concatenate 'string x y)))))
		  output)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :accumulate-test))
