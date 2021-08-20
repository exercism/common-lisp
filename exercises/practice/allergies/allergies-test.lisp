;; Ensures that allergies.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "allergies")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from allergies and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :allergies-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :allergies-test)

;; Define and enter a new FiveAM test-suite
(def-suite* allergies-suite)

(test no-allergies-at-all (is (equalp 'nil (allergies:list 0))))

(test allergic-to-just-eggs (is (equalp '("eggs") (allergies:list 1))))

(test allergic-to-just-peanuts (is (equalp '("peanuts") (allergies:list 2))))

(test allergic-to-just-strawberries
 (is (equalp '("strawberries") (allergies:list 8))))

(test allergic-to-eggs-and-peanuts
 (is (equalp '("eggs" "peanuts") (allergies:list 3))))

(test allergic-to-more-than-eggs-but-not-peanuts
 (is (equalp '("eggs" "shellfish") (allergies:list 5))))

(test allergic-to-lots-of-stuff
 (is
  (equalp '("strawberries" "tomatoes" "chocolate" "pollen" "cats")
          (allergies:list 248))))

(test allergic-to-everything
 (is
  (equalp
   '("eggs" "peanuts" "shellfish" "strawberries" "tomatoes" "chocolate"
     "pollen" "cats")
   (allergies:list 255))))

(test no-allergies-means-not-allergic
 (is (not (allergies:allergic-to-p 0 "peanuts")))
 (is (not (allergies:allergic-to-p 0 "cats")))
 (is (not (allergies:allergic-to-p 0 "strawberries"))))

(test is-allergic-to-eggs (is (allergies:allergic-to-p 1 "eggs")))

(test allergic-to-eggs-in-addition-to-other-stuff
 (is (allergies:allergic-to-p 5 "eggs")))

(test case-insensitive (is (allergies:allergic-to-p 1 "EGGS")))

(test ignore-non-allergen-score-parts
 (is
  (equalp
   '("eggs" "shellfish" "strawberries" "tomatoes" "chocolate" "pollen" "cats")
   (allergies:list 509))))

(defun run-tests (&optional (test-or-suite 'allergies-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
