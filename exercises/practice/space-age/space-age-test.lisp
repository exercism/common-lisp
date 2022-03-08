;; Ensures that space-age.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "space-age")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from space-age and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :space-age-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :space-age-test)

;; Define and enter a new FiveAM test-suite
(def-suite* space-age-suite)

(defun rounds-to (expected actual)
  (flet ((to-2-places (n) (/ (round (* 100 n)) 100.0)))
    (is (= (to-2-places expected) (to-2-places actual)))))

(test age-in-earth-years
  (rounds-to 31.69 (space-age:on-earth 1000000001)))

(test age-in-mercury-years
  (let ((seconds 2134835688))
    (rounds-to 67.65 (space-age:on-earth seconds))
    (rounds-to 280.88 (space-age:on-mercury seconds))))

(test age-in-venus-years
  (let ((seconds 189839836))
    (rounds-to 6.02 (space-age:on-earth seconds))
    (rounds-to 9.78 (space-age:on-venus seconds))))

(test age-on-mars
  (let ((seconds 2329871239))
    (rounds-to 73.83 (space-age:on-earth seconds))
    (rounds-to 39.25 (space-age:on-mars seconds))))

(test age-on-jupiter
  (let ((seconds 901876382))
    (rounds-to 28.58 (space-age:on-earth seconds))
    (rounds-to 2.41 (space-age:on-jupiter seconds))))

(test age-on-saturn
  (let ((seconds 3000000000))
    (rounds-to 95.06 (space-age:on-earth seconds))
    (rounds-to 3.23 (space-age:on-saturn seconds))))

(test age-on-uranus
  (let ((seconds 3210123456))
    (rounds-to 101.72 (space-age:on-earth seconds))
    (rounds-to 1.21 (space-age:on-uranus seconds))))

(test age-on-neptune
  (let ((seconds 8210123456))
    (rounds-to 260.16 (space-age:on-earth seconds))
    (rounds-to 1.58 (space-age:on-neptune seconds))))

(defun run-tests (&optional (test-or-suite 'space-age-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
