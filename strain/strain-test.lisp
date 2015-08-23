(ql:quickload "lisp-unit")

(defpackage #:strain-test
  (:use #:common-lisp #:lisp-unit))

#-xlisp-test (load "strain")

(in-package #:strain-test)

(define-test empty-keep
  (assert-equal '() (strain:keep #'under-10-p '())))

(define-test keep-everything
  (assert-equal '(1 2 3) (strain:keep #'under-10-p '(1 2 3))))

(define-test keep-first-last
  (assert-equal '(1 3) (strain:keep #'oddp '(1 2 3))))

(define-test keep-nothing
  (assert-equal '() (strain:keep #'evenp '(1 3 5 7))))

(define-test keep-neither-first-nor-last
  (assert-equal '(2) (strain:keep #'evenp '(1 2 3))))

(define-test keep-strings
  (let ((strs '("apple" "zebra" "banana" "zombies" "cherimoya" "zealot")))
    (assert-equal '("zebra" "zombies" "zealot")
              (strain:keep #'starts-with-z-p strs))))

(define-test empty-discard
  (assert-equal '() (strain:discard #'under-10-p '())))

(define-test discard-everything
  (assert-equal '() (strain:discard #'under-10-p '(1 2 3))))

(define-test discard-first-and-last
  (assert-equal '(2) (strain:discard #'oddp '(1 2 3))))

(define-test discard-nothing
  (assert-equal '(1 3 5 7) (strain:discard #'evenp '(1 3 5 7))))

(define-test discard-neither-first-nor-last
  (assert-equal '(1 3) (strain:discard #'evenp '(1 2 3))))

(define-test discard-strings
  (let ((strs '("apple" "zebra" "banana" "zombies" "cherimoya" "zealot")))
    (assert-equal '("apple" "banana" "cherimoya")
              (strain:discard #'starts-with-z-p strs))))

(defun under-10-p (n) (< n 10))

(defun starts-with-z-p (s) (char= (char s 0) #\z))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :strain-test))
