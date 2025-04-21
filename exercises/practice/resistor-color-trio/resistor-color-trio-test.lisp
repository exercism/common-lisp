;; Ensures that resistor-color-trio.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "resistor-color-trio")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from resistor-color-trio and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :resistor-color-trio-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :resistor-color-trio-test)

;; Define and enter a new FiveAM test-suite
(def-suite* resistor-color-trio-suite)

(test orannge-and-orange-and-black
    (let ((colors '("orange" "orange" "black")))
      (is (equal "33 ohms" (resistor-color-trio:label colors)))))

(test blue-and-grey-and-brown
    (let ((colors '("blue" "grey" "brown")))
      (is (equal "680 ohms" (resistor-color-trio:label colors)))))

(test red-and-black-and-red
    (let ((colors '("red" "black" "red")))
      (is (equal "2 kiloohms" (resistor-color-trio:label colors)))))

(test green-and-brown-and-orange
    (let ((colors '("green" "brown" "orange")))
      (is (equal "51 kiloohms" (resistor-color-trio:label colors)))))

(test yellow-and-violet-and-yellow
    (let ((colors '("yellow" "violet" "yellow")))
      (is (equal "470 kiloohms" (resistor-color-trio:label colors)))))

(test blue-and-violet-and-blue
    (let ((colors '("blue" "violet" "blue")))
      (is (equal "67 megaohms" (resistor-color-trio:label colors)))))

(test minimum-possible-value
    (let ((colors '("black" "black" "black")))
      (is (equal "0 ohms" (resistor-color-trio:label colors)))))

(test maximum-possible-value
    (let ((colors '("white" "white" "white")))
      (is (equal "99 gigaohms" (resistor-color-trio:label colors)))))

(test first-two-colors-make-an-invalid-octal-number
    (let ((colors '("black" "grey" "black")))
      (is (equal "8 ohms" (resistor-color-trio:label colors)))))

(test ignore-extra-colors
    (let ((colors '("blue" "green" "yellow" "orange")))
      (is (equal "650 kiloohms" (resistor-color-trio:label colors)))))

(defun run-tests (&optional (test-or-suite 'resistor-color-trio-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
