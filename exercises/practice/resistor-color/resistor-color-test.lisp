;; Ensures that resistor-color.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "resistor-color")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from resistor-color and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :resistor-color-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :resistor-color-test)

;; Define and enter a new FiveAM test-suite
(def-suite* resistor-color-suite)

(test black
    (let ((color "black"))
      (is (= 0 (resistor-color:color-code color)))))

(test white
    (let ((color "white"))
      (is (= 9 (resistor-color:color-code color)))))

(test orange
    (let ((color "orange"))
      (is (= 3 (resistor-color:color-code color)))))

(test colors
    (let (
          (result '("black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white")))
      (is (equal result (resistor-color:colors )))))

(defun run-tests (&optional (test-or-suite 'resistor-color-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
