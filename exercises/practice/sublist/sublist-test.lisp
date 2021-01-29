(ql:quickload "lisp-unit")
#-xlisp-test (load "sublist")

(defpackage #:sublist-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:sublist-test)


;; Equal lists tests:
(define-test empty-lists
  (assert-equal :equal (sublist:sublist (list)
                                         (list))))

(define-test list-equals-itself
  (assert-equal :equal (sublist:sublist (list 1 2 3)
                                         (list 1 2 3))))


;; Unequal lists tests:
(define-test different-lists
  (assert-equal :unequal (sublist:sublist (list 1 2 3)
                                           (list 2 3 4))))

(define-test first-list-missing-element-from-second-list
  (assert-equal :unequal (sublist:sublist (list 1 3)
                                           (list 1 2 3))))

(define-test second-list-missing-element-from-first-list
  (assert-equal :unequal (sublist:sublist (list 1 2 3)
                                           (list 1 3))))

(define-test order-matters-to-a-lists
  (assert-equal :unequal (sublist:sublist (list 1 2 3)
                                           (list 3 2 1))))

(define-test same-digits-different-numbers
  (assert-equal :unequal (sublist:sublist (list 1 0 1)
                                           (list 10 1))))

;; Sublist lists tests:
(define-test empty-list-within-non-empty-list
  (assert-equal :sublist (sublist:sublist (list)
                                           (list 1 2 3))))

(define-test false-start
  (assert-equal :sublist (sublist:sublist (list 1 2 5)
                                           (list 0 1 2 3 1 2 5 6))))

(define-test consecutive
  (assert-equal :sublist (sublist:sublist (list 1 1 2)
                                           (list 0 1 1 1 2 1 2))))

(define-test sublist-at-start
  (assert-equal :sublist (sublist:sublist (list 0 1 2)
                                           (list 0 1 2 3 4 5))))

(define-test sublist-in-middle
  (assert-equal :sublist (sublist:sublist (list 2 3 4)
                                           (list 0 1 2 3 4 5))))

(define-test sublist-at-end
  (assert-equal :sublist (sublist:sublist (list 3 4 5)
                                           (list 0 1 2 3 4 5))))


;; Superlist lists tests:
(define-test not-empty-list-contains-empty-list
  (assert-equal :superlist (sublist:sublist (list 1 2 3)
                                             (list))))

(define-test at-start-of-superlist
  (assert-equal :superlist (sublist:sublist (list 0 1 2 3 4 5)
                                             (list 0 1 2))))

(define-test in-middle-of-superlist
  (assert-equal :superlist (sublist:sublist (list 0 1 2 3 4 5)
                                             (list 2 3))))

(define-test at-end-superlist
  (assert-equal :superlist (sublist:sublist (list 0 1 2 3 4 5)
                                             (list 3 4 5))))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all))
