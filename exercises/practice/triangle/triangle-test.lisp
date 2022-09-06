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

(def-suite* equilateral-suite :in triangle-suite)

(test all-sides-are-equal
  (is (triangle:triangle-type-p :equilateral 2 2 2)))

(test any-side-is-unequal
  (is (not (triangle:triangle-type-p :equilateral 2 3 2))))

(test no-sides-are-equal
  (is (not (triangle:triangle-type-p :equilateral 5 4 6))))

(test all-zero-sides-is-not-a-triangle
  (is (not (triangle:triangle-type-p :equilateral 0 0 0))))

(test sides-may-be-floats
  (is (triangle:triangle-type-p :equilateral 0.5 0.5 0.5)))

(def-suite* isosceles-suite :in triangle-suite)

(test last-two-sides-are-equal
  (is (triangle:triangle-type-p :isosceles 3 4 4)))

(test first-two-sides-are-equal
  (is (triangle:triangle-type-p :isosceles 4 4 3)))

(test first-and-last-sides-are-equal
  (is (triangle:triangle-type-p :isosceles 4 3 4)))

(test equilateral-triangles-are-also-isosceles
  (is (triangle:triangle-type-p :isosceles 4 4 4)))

(test no-sides-are-equal
  (is (not (triangle:triangle-type-p :isosceles 2 3 4))))

(test first-triangle-inequality-violation
  (is (not (triangle:triangle-type-p :isosceles 1 1 3))))

(test second-triangle-inequality-violation
  (is (not (triangle:triangle-type-p :isosceles 1 3 1))))

(test third-triangle-inequality-violation
  (is (not (triangle:triangle-type-p :isosceles 3 1 1))))

(test sides-may-be-floats
  (is (triangle:triangle-type-p :isosceles 0.5 0.4 0.5)))

(def-suite* scalene-suite :in triangle-suite)

(test no-sides-are-equal
  (is (triangle:triangle-type-p :scalene 5 4 6)))

(test all-sides-are-equal
  (is (not (triangle:triangle-type-p :scalene 4 4 4))))

(test first-and-second-sides-are-equal
  (is (not (triangle:triangle-type-p :scalene 4 4 3))))

(test first-and-third-sides-are-equal
  (is (not (triangle:triangle-type-p :scalene 4 3 4))))

(test second-and-third-sides-are-equal
  (is (not (triangle:triangle-type-p :scalene 3 4 4))))

(test may-not-violate-triangle-inequality
  (is (not (triangle:triangle-type-p :scalene 7 3 2))))

(test sides-may-be-floats
  (is (triangle:triangle-type-p :scalene 0.5 0.4 0.6)))

(defun run-tests (&optional (test-or-suite 'triangle-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
