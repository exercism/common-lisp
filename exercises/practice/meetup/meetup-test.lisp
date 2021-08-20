;; Ensures that meetup.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "meetup")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from meetup and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :meetup-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :meetup-test)

;; Define and enter a new FiveAM test-suite
(def-suite* meetup-suite)

(test monteeth-of-may-2013
 (is (equal '(2013 5 13) (meetup:meetup 5 2013 :monday :teenth))))

(test monteenth-of-august-2013
 (is (equal '(2013 8 19) (meetup:meetup 8 2013 :monday :teenth))))

(test monteenth-of-september-2013
 (is (equal '(2013 9 16) (meetup:meetup 9 2013 :monday :teenth))))

(test tuesteenth-of-march-2013
 (is (equal '(2013 3 19) (meetup:meetup 3 2013 :tuesday :teenth))))

(test tuesteenth-of-april-2013
 (is (equal '(2013 4 16) (meetup:meetup 4 2013 :tuesday :teenth))))

(test tuesteenth-of-august-2013
 (is (equal '(2013 8 13) (meetup:meetup 8 2013 :tuesday :teenth))))

(test wednesteenth-of-january-2013
 (is (equal '(2013 1 16) (meetup:meetup 1 2013 :wednesday :teenth))))

(test wednesteenth-of-february-2013
 (is (equal '(2013 2 13) (meetup:meetup 2 2013 :wednesday :teenth))))

(test wednesteenth-of-june-2013
 (is (equal '(2013 6 19) (meetup:meetup 6 2013 :wednesday :teenth))))

(test thursteenth-of-may-2013
 (is (equal '(2013 5 16) (meetup:meetup 5 2013 :thursday :teenth))))

(test thursteenth-of-june-2013
 (is (equal '(2013 6 13) (meetup:meetup 6 2013 :thursday :teenth))))

(test thursteenth-of-september-2013
 (is (equal '(2013 9 19) (meetup:meetup 9 2013 :thursday :teenth))))

(test friteenth-of-april-2013
 (is (equal '(2013 4 19) (meetup:meetup 4 2013 :friday :teenth))))

(test friteenth-of-august-2013
 (is (equal '(2013 8 16) (meetup:meetup 8 2013 :friday :teenth))))

(test friteenth-of-september-2013
 (is (equal '(2013 9 13) (meetup:meetup 9 2013 :friday :teenth))))

(test saturteenth-of-february-2013
 (is (equal '(2013 2 16) (meetup:meetup 2 2013 :saturday :teenth))))

(test saturteenth-of-april-2013
 (is (equal '(2013 4 13) (meetup:meetup 4 2013 :saturday :teenth))))

(test saturteenth-of-october-2013
 (is (equal '(2013 10 19) (meetup:meetup 10 2013 :saturday :teenth))))

(test sunteenth-of-may-2013
 (is (equal '(2013 5 19) (meetup:meetup 5 2013 :sunday :teenth))))

(test sunteenth-of-june-2013
 (is (equal '(2013 6 16) (meetup:meetup 6 2013 :sunday :teenth))))

(test sunteenth-of-october-2013
 (is (equal '(2013 10 13) (meetup:meetup 10 2013 :sunday :teenth))))

(test first-monday-of-march-2013
 (is (equal '(2013 3 4) (meetup:meetup 3 2013 :monday :first))))

(test first-monday-of-april-2013
 (is (equal '(2013 4 1) (meetup:meetup 4 2013 :monday :first))))

(test first-tuesday-of-may-2013
 (is (equal '(2013 5 7) (meetup:meetup 5 2013 :tuesday :first))))

(test first-tuesday-of-june-2013
 (is (equal '(2013 6 4) (meetup:meetup 6 2013 :tuesday :first))))

(test first-wednesday-of-july-2013
 (is (equal '(2013 7 3) (meetup:meetup 7 2013 :wednesday :first))))

(test first-wednesday-of-august-2013
 (is (equal '(2013 8 7) (meetup:meetup 8 2013 :wednesday :first))))

(test first-thursday-of-september-2013
 (is (equal '(2013 9 5) (meetup:meetup 9 2013 :thursday :first))))

(test first-thursday-of-october-2013
 (is (equal '(2013 10 3) (meetup:meetup 10 2013 :thursday :first))))

(test first-friday-of-november-2013
 (is (equal '(2013 11 1) (meetup:meetup 11 2013 :friday :first))))

(test first-friday-of-december-2013
 (is (equal '(2013 12 6) (meetup:meetup 12 2013 :friday :first))))

(test first-saturday-of-january-2013
 (is (equal '(2013 1 5) (meetup:meetup 1 2013 :saturday :first))))

(test first-saturday-of-january-2013
 (is (equal '(2013 2 2) (meetup:meetup 2 2013 :saturday :first))))

(test first-sunday-of-march-2013
 (is (equal '(2013 3 3) (meetup:meetup 3 2013 :sunday :first))))

(test first-sunday-of-april-2013
 (is (equal '(2013 4 7) (meetup:meetup 4 2013 :sunday :first))))

(test second-monday-of-march-2013
 (is (equal '(2013 3 11) (meetup:meetup 3 2013 :monday :second))))

(test second-monday-of-april-2013
 (is (equal '(2013 4 8) (meetup:meetup 4 2013 :monday :second))))

(test second-tuesday-of-may-2013
 (is (equal '(2013 5 14) (meetup:meetup 5 2013 :tuesday :second))))

(test second-tuesday-of-june-2013
 (is (equal '(2013 6 11) (meetup:meetup 6 2013 :tuesday :second))))

(test second-wednesday-of-july-2013
 (is (equal '(2013 7 10) (meetup:meetup 7 2013 :wednesday :second))))

(test second-wednesday-of-august-2013
 (is (equal '(2013 8 14) (meetup:meetup 8 2013 :wednesday :second))))

(test second-thursday-of-september-2013
 (is (equal '(2013 9 12) (meetup:meetup 9 2013 :thursday :second))))

(test second-thursday-of-october-2013
 (is (equal '(2013 10 10) (meetup:meetup 10 2013 :thursday :second))))

(test second-friday-of-november-2013
 (is (equal '(2013 11 8) (meetup:meetup 11 2013 :friday :second))))

(test second-friday-of-december-2013
 (is (equal '(2013 12 13) (meetup:meetup 12 2013 :friday :second))))

(test second-saturday-of-january-2013
 (is (equal '(2013 1 12) (meetup:meetup 1 2013 :saturday :second))))

(test second-saturday-of-february-2013
 (is (equal '(2013 2 9) (meetup:meetup 2 2013 :saturday :second))))

(test second-sunday-of-march-2013
 (is (equal '(2013 3 10) (meetup:meetup 3 2013 :sunday :second))))

(test second-sunday-of-april-2013
 (is (equal '(2013 4 14) (meetup:meetup 4 2013 :sunday :second))))

(test third-monday-of-march-2013
 (is (equal '(2013 3 18) (meetup:meetup 3 2013 :monday :third))))

(test third-monday-of-april-2013
 (is (equal '(2013 4 15) (meetup:meetup 4 2013 :monday :third))))

(test third-tuesday-of-may-2013
 (is (equal '(2013 5 21) (meetup:meetup 5 2013 :tuesday :third))))

(test third-tuesday-of-june-2013
 (is (equal '(2013 6 18) (meetup:meetup 6 2013 :tuesday :third))))

(test third-wednesday-of-july-2013
 (is (equal '(2013 7 17) (meetup:meetup 7 2013 :wednesday :third))))

(test third-wednesday-of-august-2013
 (is (equal '(2013 8 21) (meetup:meetup 8 2013 :wednesday :third))))

(test third-thursday-of-september-2013
 (is (equal '(2013 9 19) (meetup:meetup 9 2013 :thursday :third))))

(test third-thursday-of-october-2013
 (is (equal '(2013 10 17) (meetup:meetup 10 2013 :thursday :third))))

(test third-friday-of-november-2013
 (is (equal '(2013 11 15) (meetup:meetup 11 2013 :friday :third))))

(test third-friday-of-december-2013
 (is (equal '(2013 12 20) (meetup:meetup 12 2013 :friday :third))))

(test third-saturday-of-january-2013
 (is (equal '(2013 1 19) (meetup:meetup 1 2013 :saturday :third))))

(test third-saturday-of-february-2013
 (is (equal '(2013 2 16) (meetup:meetup 2 2013 :saturday :third))))

(test third-sunday-of-march-2013
 (is (equal '(2013 3 17) (meetup:meetup 3 2013 :sunday :third))))

(test third-sunday-of-april-2013
 (is (equal '(2013 4 21) (meetup:meetup 4 2013 :sunday :third))))

(test fourth-monday-of-march-2013
 (is (equal '(2013 3 25) (meetup:meetup 3 2013 :monday :fourth))))

(test fourth-monday-of-april-2013
 (is (equal '(2013 4 22) (meetup:meetup 4 2013 :monday :fourth))))

(test fourth-tuesday-of-may-2013
 (is (equal '(2013 5 28) (meetup:meetup 5 2013 :tuesday :fourth))))

(test fourth-tuesday-of-june-2013
 (is (equal '(2013 6 25) (meetup:meetup 6 2013 :tuesday :fourth))))

(test fourth-wednesday-of-july-2013
 (is (equal '(2013 7 24) (meetup:meetup 7 2013 :wednesday :fourth))))

(test fourth-wednesday-of-august-2013
 (is (equal '(2013 8 28) (meetup:meetup 8 2013 :wednesday :fourth))))

(test fourth-thursday-of-september-2013
 (is (equal '(2013 9 26) (meetup:meetup 9 2013 :thursday :fourth))))

(test fourth-thursday-of-october-2013
 (is (equal '(2013 10 24) (meetup:meetup 10 2013 :thursday :fourth))))

(test fourth-friday-of-november-2013
 (is (equal '(2013 11 22) (meetup:meetup 11 2013 :friday :fourth))))

(test fourth-friday-of-december-2013
 (is (equal '(2013 12 27) (meetup:meetup 12 2013 :friday :fourth))))

(test fourth-saturday-of-january-2013
 (is (equal '(2013 1 26) (meetup:meetup 1 2013 :saturday :fourth))))

(test fourth-saturday-of-february-2013
 (is (equal '(2013 2 23) (meetup:meetup 2 2013 :saturday :fourth))))

(test fourth-sunday-of-march-2013
 (is (equal '(2013 3 24) (meetup:meetup 3 2013 :sunday :fourth))))

(test fourth-sunday-of-april-2013
 (is (equal '(2013 4 28) (meetup:meetup 4 2013 :sunday :fourth))))

(test last-monday-of-march-2013
 (is (equal '(2013 3 25) (meetup:meetup 3 2013 :monday :last))))

(test last-monday-of-april-2013
 (is (equal '(2013 4 29) (meetup:meetup 4 2013 :monday :last))))

(test last-tuesday-of-may-2013
 (is (equal '(2013 5 28) (meetup:meetup 5 2013 :tuesday :last))))

(test last-tuesday-of-june-2013
 (is (equal '(2013 6 25) (meetup:meetup 6 2013 :tuesday :last))))

(test last-wednesday-of-july-2013
 (is (equal '(2013 7 31) (meetup:meetup 7 2013 :wednesday :last))))

(test last-wednesday-of-august-2013
 (is (equal '(2013 8 28) (meetup:meetup 8 2013 :wednesday :last))))

(test last-thursday-of-september-2013
 (is (equal '(2013 9 26) (meetup:meetup 9 2013 :thursday :last))))

(test last-thursday-of-october-2013
 (is (equal '(2013 10 31) (meetup:meetup 10 2013 :thursday :last))))

(test last-friday-of-november-2013
 (is (equal '(2013 11 29) (meetup:meetup 11 2013 :friday :last))))

(test last-friday-of-december-2013
 (is (equal '(2013 12 27) (meetup:meetup 12 2013 :friday :last))))

(test last-saturday-of-january-2013
 (is (equal '(2013 1 26) (meetup:meetup 1 2013 :saturday :last))))

(test last-saturday-of-february-2013
 (is (equal '(2013 2 23) (meetup:meetup 2 2013 :saturday :last))))

(test last-sunday-of-march-2013
 (is (equal '(2013 3 31) (meetup:meetup 3 2013 :sunday :last))))

(test last-sunday-of-april-2013
 (is (equal '(2013 4 28) (meetup:meetup 4 2013 :sunday :last))))

(defun run-tests (&optional (test-or-suite 'meetup-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
