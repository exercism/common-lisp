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

(test testing-for-eggs-allergy->not-allergic-to-anything
  (is-false (allergies:allergic-to-p 0 "eggs") ))

(test testing-for-eggs-allergy->allergic-only-to-eggs
  (is-true (allergies:allergic-to-p 1 "eggs")))

(test testing-for-eggs-allergy->allergic-to-eggs-and-something-else
  (is-true (allergies:allergic-to-p 3 "eggs")))

(test testing-for-eggs-allergy->allergic-to-something-but-not-eggs
  (is-false (allergies:allergic-to-p 2 "eggs")))

(test testing-for-eggs-allergy->allergic-to-everything
  (is-true (allergies:allergic-to-p 255 "eggs")))

(test testing-for-peanuts-allergy->not-allergic-to-anything
  (is-false (allergies:allergic-to-p 0 "peanuts")))

(test testing-for-peanuts-allergy->allergic-only-to-peanuts
  (is-true (allergies:allergic-to-p 2 "peanuts")))

(test testing-for-peanuts-allergy->allergic-to-peanuts-and-something-else
  (is-true (allergies:allergic-to-p 7 "peanuts")))

(test testing-for-peanuts-allergy->allergic-to-something-but-not-peanuts
  (is-false (allergies:allergic-to-p 5 "peanuts")))

(test testing-for-peanuts-allergy->allergic-to-everything
  (is-true (allergies:allergic-to-p 255 "peanuts")))

(test testing-for-shellfish-allergy->not-allergic-to-anything
  (is-false (allergies:allergic-to-p 0 "shellfish")))

(test testing-for-shellfish-allergy->allergic-only-to-shellfish
  (is-true (allergies:allergic-to-p 4 "shellfish")))

(test testing-for-shellfish-allergy->allergic-to-shellfish-and-something-else
  (is-true (allergies:allergic-to-p 14 "shellfish")))

(test testing-for-shellfish-allergy->allergic-to-something-but-not-shellfish
  (is-false (allergies:allergic-to-p 10 "shellfish")))

(test testing-for-shellfish-allergy->allergic-to-everything
  (is-true (allergies:allergic-to-p 255 "shellfish")))

(test testing-for-strawberries-allergy->not-allergic-to-anything
  (is-false (allergies:allergic-to-p 0 "strawberries")))

(test testing-for-strawberries-allergy->allergic-only-to-strawberries
  (is-true (allergies:allergic-to-p 8 "strawberries")))

(test testing-for-strawberries-allergy->allergic-to-strawberries-and-something-else
  (is-true (allergies:allergic-to-p 28 "strawberries")))

(test testing-for-strawberries-allergy->allergic-to-something-but-not-strawberries
  (is-false (allergies:allergic-to-p 20 "strawberries")))

(test testing-for-strawberries-allergy->allergic-to-everything
  (is-true (allergies:allergic-to-p 255 "strawberries")))

(test testing-for-tomatoes-allergy->not-allergic-to-anything
  (is-false (allergies:allergic-to-p 0 "tomatoes")))

(test testing-for-tomatoes-allergy->allergic-only-to-tomatoes
  (is-true (allergies:allergic-to-p 16 "tomatoes")))

(test testing-for-tomatoes-allergy->allergic-to-tomatoes-and-something-else
  (is-true (allergies:allergic-to-p 56 "tomatoes")))

(test testing-for-tomatoes-allergy->allergic-to-something-but-not-tomatoes
  (is-false (allergies:allergic-to-p 40 "tomatoes")))

(test testing-for-tomatoes-allergy->allergic-to-everything
  (is-true (allergies:allergic-to-p 255 "tomatoes")))

(test testing-for-chocolate-allergy->not-allergic-to-anything
  (is-false (allergies:allergic-to-p 0 "chocolate")))

(test testing-for-chocolate-allergy->allergic-only-to-chocolate
  (is-true (allergies:allergic-to-p 32 "chocolate")))

(test testing-for-chocolate-allergy->allergic-to-chocolate-and-something-else
  (is-true (allergies:allergic-to-p 112 "chocolate")))

(test testing-for-chocolate-allergy->allergic-to-something-but-not-chocolate
  (is-false (allergies:allergic-to-p 80 "chocolate")))

(test testing-for-chocolate-allergy->allergic-to-everything
  (is-true (allergies:allergic-to-p 255 "chocolate")))

(test testing-for-pollen-allergy->not-allergic-to-anything
  (is-false (allergies:allergic-to-p 0 "pollen")))

(test testing-for-pollen-allergy->allergic-only-to-pollen
  (is-true (allergies:allergic-to-p 64 "pollen")))

(test testing-for-pollen-allergy->allergic-to-pollen-and-something-else
  (is-true (allergies:allergic-to-p 224 "pollen")))

(test testing-for-pollen-allergy->allergic-to-something-but-not-pollen
  (is-false (allergies:allergic-to-p 160 "pollen")))

(test testing-for-pollen-allergy->allergic-to-everything
  (is-true (allergies:allergic-to-p 255 "pollen")))

(test testing-for-cats-allergy->not-allergic-to-anything
  (is-false (allergies:allergic-to-p 0 "cats")))

(test testing-for-cats-allergy->allergic-only-to-cats
  (is-true (allergies:allergic-to-p 128 "cats")))

(test testing-for-cats-allergy->allergic-to-cats-and-something-else
  (is-true (allergies:allergic-to-p 192 "cats")))

(test testing-for-cats-allergy->allergic-to-something-but-not-cats
  (is-false (allergies:allergic-to-p 64 "cats")))

(test testing-for-cats-allergy->allergic-to-everything
  (is-true (allergies:allergic-to-p 255 "cats")))

(test list-when->no-allergies
  (is (equal '() (allergies:list 0))))

(test list-when->just-eggs
  (is (equal '("eggs") (allergies:list 1))))

(test list-when->just-peanuts
  (is (equal '("peanuts") (allergies:list 2))))

(test list-when->just-strawberries
  (is (equal '("strawberries") (allergies:list 8))))

(test list-when->eggs-and-peanuts
  (is (equal '("eggs" "peanuts") (allergies:list 3))))

(test list-when->more-than-eggs-but-not-peanuts
  (is (equal '("eggs" "shellfish") (allergies:list 5))))

(test list-when->lots-of-stuff
  (is (equal '("strawberries" "tomatoes" "chocolate" "pollen" "cats")
             (allergies:list 248))))

(test list-when->everything
  (is (equal '("eggs" "peanuts" "shellfish" "strawberries" "tomatoes"
               "chocolate" "pollen" "cats")
             (allergies:list 255))))

(test list-when->no-allergen-score-parts
  (is (equal '("eggs" "shellfish" "strawberries" "tomatoes" "chocolate"
               "pollen" "cats")
             (allergies:list 509))))

(test list-when->no-allergen-score-parts-without-highest-valid-score
  (is (equal '("eggs") (allergies:list 257))))

(defun run-tests (&optional (test-or-suite 'allergies-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
