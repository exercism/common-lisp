;; Ensures that leap.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "leap")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from leap and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :leap-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :leap-test)

;; Define and enter a new FiveAM test-suite
(def-suite* leap-suite)

(test vanilla-leap-year (is (leap:leap-year-p 1996)))

(test any-old-year (is (not (leap:leap-year-p 1997))))

(test non-leap-even-year (is (not (leap:leap-year-p 1998))))

(test century (is (not (leap:leap-year-p 1900))))

(test exceptional-century (is (leap:leap-year-p 2400)))

(defun run-tests (&optional (test-or-suite 'leap-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
