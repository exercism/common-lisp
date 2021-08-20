;; Ensures that triangle.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "triangle")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from triangle and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :triangle-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :triangle-test)

;; Define and enter a new FiveAM test-suite
(def-suite* triangle-suite)

(test equilateral-1 (is (equal :equilateral (triangle:triangle 2 2 2))))

(test equilateral-2 (is (equal :equilateral (triangle:triangle 10 10 10))))

(test isoceles-1 (is (equal :isosceles (triangle:triangle 3 4 4))))

(test isoceles-2 (is (equal :isosceles (triangle:triangle 4 3 4))))

(test scalene (is (equal :scalene (triangle:triangle 3 4 5))))

(test invalid-1 (is (equal :illogical (triangle:triangle 1 1 50))))

(test invalid-2 (is (equal :illogical (triangle:triangle 1 2 1))))

(defun run-tests (&optional (test-or-suite 'triangle-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
