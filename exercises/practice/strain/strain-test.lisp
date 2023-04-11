;; Ensures that strain.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "strain")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from strain and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :strain-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :strain-test)

;; Define and enter a new FiveAM test-suite
(def-suite* strain-suite)

(test empty-keep (is (equal 'nil (strain:keep #'under-10-p 'nil))))

(test keep-everything (is (equal '(1 2 3) (strain:keep #'under-10-p '(1 2 3)))))

(test keep-nothing (is (equal 'nil (strain:keep #'evenp '(1 3 5 7)))))

(test keep-first-last (is (equal '(1 3) (strain:keep #'oddp '(1 2 3)))))

(test keep-neither-first-nor-last
 (is (equal '(2) (strain:keep #'evenp '(1 2 3)))))

(test keep-strings
 (let ((strs '("apple" "zebra" "banana" "zombies" "cherimoya" "zealot")))
   (is
    (equal '("zebra" "zombies" "zealot")
           (strain:keep #'starts-with-z-p strs)))))

(test keep-lists
 (let ((lists '( (1 2 3) (5 5 5) (5 1 2) (2 1 2) (1 5 2) (2 2 1) (1 2 5) )))
   (is (equal '( (5 5 5) (5 1 2) (1 5 2) (1 2 5) )
              (strain:keep #'contains-5 lists)))))

(test empty-discard (is (equal 'nil (strain:discard #'under-10-p 'nil))))

(test discard-everything
 (is (equal 'nil (strain:discard #'under-10-p '(1 2 3)))))

(test discard-nothing
 (is (equal '(1 3 5 7) (strain:discard #'evenp '(1 3 5 7)))))

(test discard-first-and-last (is (equal '(2) (strain:discard #'oddp '(1 2 3)))))

(test discard-neither-first-nor-last
 (is (equal '(1 3) (strain:discard #'evenp '(1 2 3)))))

(test discard-strings
 (let ((strs '("apple" "zebra" "banana" "zombies" "cherimoya" "zealot")))
   (is
    (equal '("apple" "banana" "cherimoya")
           (strain:discard #'starts-with-z-p strs)))))


(test discard-list
 (let ((list '( (1 2 3) (5 5 5) (5 1 2) (2 1 2) (1 5 2) (2 2 1) (1 2 5))))
   (is (equal '( (1 2 3) (2 1 2) (2 2 1) )
              (strain:discard #'contains-5 list)))))

(defun under-10-p (n) (< n 10))

(defun starts-with-z-p (s) (char= (char s 0) #\z))

(defun contains-5 (l) (member 5 l))

(defun run-tests (&optional (test-or-suite 'strain-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
