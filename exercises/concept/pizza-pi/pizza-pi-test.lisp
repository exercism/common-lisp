;; Ensures that pizza-pi.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "pizza-pi")
  (ql:quickload :fiveam))

;; Defines the testing package with symbols from pizza-pi and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :pizza-pi-test
  (:use :cl :fiveam :pizza-pi)
  (:export :run-tests))

;; Enter the testing package
(in-package :pizza-pi-test)

;; Define and enter a new FiveAM test-suite
(def-suite pizza-pi-suite)
(in-suite pizza-pi-suite)

(test dough-ratio "Calculate the grams of dough needed for given number and size of pizzas"
  (is (= 1648 (dough-calculator 4 30)))
  (is (= 895 (dough-calculator 2 35)))
  (is (= 2048 (dough-calculator 6 20)))
  (is (= 306 (dough-calculator 1 15)))
  (is (= 1353 (dough-calculator 5 10))))

(defun rounds-to (expected actual)
  (flet ((to-2-places (n) (/ (round (* 100 n)) 100.0)))
    (is (= (to-2-places expected) (to-2-places actual)))))

(test splash-of-sauces "Calculates the diameter of a pizza from the amount of sauce applied"
  (is (rounds-to 32.57 (size-from-sauce 250)))
  (is (rounds-to 20.60 (size-from-sauce 100)))
  (is (rounds-to 37.42 (size-from-sauce 330)))
  (is (rounds-to 46.52 (size-from-sauce 510)))
  (is (rounds-to 53.72 (size-from-sauce 680))))

(test cheese-please "Calculates the number of pizzas of a certain size that can be made from an amount of cheese"
  (is (= 3 (pizzas-per-cube 25 30)))
  (is (= 1 (pizzas-per-cube 15 20)))
  (is (= 132 (pizzas-per-cube 100 40)))
  (is (= 0 (pizzas-per-cube 5 10)))
  (is (= 85 (pizzas-per-cube 45 15))))

(test fair-share "Calculates if some number of pizzas can be evenly divided between friends"
  (is-true  (fair-share-p 3 4))
  (is-false (fair-share-p 2 3))
  (is-false (fair-share-p 4 5))
  (is-true  (fair-share-p 4 8))
  (is-true  (fair-share-p 1 4))
  (is-true  (fair-share-p 21 7))
  (is-false (fair-share-p 11 10))
  (is-true  (fair-share-p 0 5))
  (is-false (fair-share-p 17 5))
  (is-true  (fair-share-p 16 64)))

(defun run-tests (&optional (test-or-suite 'pizza-pi-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
