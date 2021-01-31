(ql:quickload "lisp-unit")
#-xlisp-test (load "robot-name")

(defpackage #:robot-name-test
  (:use #:common-lisp #:lisp-unit))

(in-package #:robot-name-test)

(defun is-upper-alpha-p (c) (char<= #\A c #\Z))
(defun is-digit-p (c) (char-not-greaterp #\0 c #\9))

(defparameter *robbie* (robot-name:build-robot))
(defparameter *clutz* (robot-name:build-robot))

(define-test name-matches-expected-pattern
  (let ((name (robot-name:robot-name *robbie*)))
    (assert-true (= (length name) 5))
    (assert-true (every #'is-upper-alpha-p (subseq name 0 2)))
    (assert-true (every #'is-digit-p (subseq name 2 5)))))

(define-test name-is-persistent
  (assert-equal (robot-name:robot-name *robbie*) (robot-name:robot-name *robbie*)))

(define-test different-robots-have-different-names
  (assert-equality (complement #'equal)
      (robot-name:robot-name *clutz*)
      (robot-name:robot-name *robbie*)))

(define-test name-can-be-reset
  (let* ((robot (robot-name:build-robot))
         (original-name (robot-name:robot-name robot)))
    (robot-name:reset-name robot)
    (assert-equality (complement #'equal)
        (robot-name:robot-name robot)
        original-name)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :robot-name-test))
