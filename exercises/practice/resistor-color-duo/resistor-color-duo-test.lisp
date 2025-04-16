;; Ensures that resistor-color-duo.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "resistor-color-duo")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from resistor-color-duo and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :resistor-color-duo-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :resistor-color-duo-test)

;; Define and enter a new FiveAM test-suite
(def-suite* resistor-color-duo-suite)

(test brown-and-black
    (let ((colors '("brown" "black")))
      (is (= 10 (resistor-color-duo:value colors)))))

(test blue-and-grey
    (let ((colors '("blue" "grey")))
      (is (= 68 (resistor-color-duo:value colors)))))

(test yellow-and-violet
    (let ((colors '("yellow" "violet")))
      (is (= 47 (resistor-color-duo:value colors)))))

(test white-and-red
    (let ((colors '("white" "red")))
      (is (= 92 (resistor-color-duo:value colors)))))

(test orange-and-orange
    (let ((colors '("orange" "orange")))
      (is (= 33 (resistor-color-duo:value colors)))))

(test ignore-additional-colors
    (let ((colors '("green" "brown" "orange")))
      (is (= 51 (resistor-color-duo:value colors)))))

(test black-and-brown-one-digit
    (let ((colors '("black" "brown")))
      (is (= 1 (resistor-color-duo:value colors)))))

(defun run-tests (&optional (test-or-suite 'resistor-color-duo-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
