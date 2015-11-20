(ql:quickload "lisp-unit")

(defpackage #:robot-name-test
  (:use #:common-lisp #:lisp-unit))

#-xlisp-test (load "robot")

(in-package #:robot-name-test)

(defun is-upper-alpha-p (c) (char<= #\A c #\Z))
(defun is-digit-p (c) (char-not-greaterp #\0 c #\9))

(defparameter *robbie* (robot:build-robot))
(defparameter *clutz* (robot:build-robot))

(define-test name-matches-expected-pattern
  (let ((name (robot:robot-name *robbie*)))
    (assert-true (and (= (length name) 5)
		      (every #'is-upper-alpha-p (subseq name 0 2))
		      (every #'is-digit-p (subseq name 2 5))))))

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

(defparameter *robot-names* (make-hash-table :test 'equal))

(defun test-unique-names ()
  (loop
     ;; Full check will be slow but there are enough
     ;; iterations to detect non-unique names.
     ;; If in future we will be checking all possible names
     ;; we should not forget about names that were already used
     ;; by previous tests
     with max = (* 26 26 100)
     with started = (get-universal-time)
     with max-execution-time = 3 ; seconds
     for i upto max
     for name = (robot:robot-name (robot:build-robot))
     if (gethash name *robot-names*) do
       (return 'name-collision)
     if (> (- (get-universal-time) started) max-execution-time) do
       (return 'implementation-is-slow)
     do (setf (gethash name *robot-names*) name)))

(define-test names-are-unique ()
             (assert-eql nil (test-unique-names)))

#-xlisp-test
(let ((*print-errors* t)
      (*print-failures* t))
  (run-tests :all :robot-name-test))
