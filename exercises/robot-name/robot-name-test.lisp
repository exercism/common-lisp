(ql:quickload "lisp-unit")
#-xlisp-test (load "robot")

(defpackage #:robot-name-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:robot-name-test)

(defun is-upper-alpha-p (c) (char<= #\A c #\Z))
(defun is-digit-p (c) (char-not-greaterp #\0 c #\9))

(defparameter *robbie* (robot:build-robot))
(defparameter *clutz* (robot:build-robot))

(define-test name-matches-expected-pattern
  (let ((name (robot:robot-name *robbie*)))
    (assert-true (= (length name) 5))
    (assert-true (every #'is-upper-alpha-p (subseq name 0 2)))
    (assert-true (every #'is-digit-p (subseq name 2 5)))))

(define-test name-is-persistent
  (assert-equal (robot:robot-name *robbie*) (robot:robot-name *robbie*)))

(define-test different-robots-have-different-names
  (assert-equality (complement #'equal)
      (robot:robot-name *clutz*)
      (robot:robot-name *robbie*)))

(define-test name-can-be-reset
  (let* ((robot (robot:build-robot))
         (original-name (robot:robot-name robot)))
    (robot:reset-name robot)
    (assert-equality (complement #'equal)
        (robot:robot-name robot)
        original-name)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :robot-name-test))
