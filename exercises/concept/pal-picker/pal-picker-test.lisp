;; Ensures that pal-picker.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "pal-picker")
  (ql:quickload :fiveam))

;; Defines the testing package with symbols from pal-picker and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :pal-picker-test
  (:use :cl :fiveam :pal-picker)
  (:export :run-tests))

;; Enter the testing package
(in-package :pal-picker-test)

;; Define and enter a new FiveAM test-suite
(def-suite pal-picker-suite)
(in-suite pal-picker-suite)

(test pick-a-pal "Maps personality traits to fitting pets"
  (is (string= "Cat" (pal-picker :lazy)))
  (is (string= "Dog" (pal-picker :energetic)))
  (is (string= "Fish" (pal-picker :quiet)))
  (is (string= "Rabbit" (pal-picker :hungry)))
  (is (string= "Bird" (pal-picker :talkative)))
  (is (string= "I don't know... A dragon?" (pal-picker :fireproof))))

(test natural-habitat "Maps pet weights to habitat sizes"
  (is (eql :massive (habitat-fitter 100)))
  (is (eql :massive (habitat-fitter 40)))
  (is (eql :large (habitat-fitter 39)))
  (is (eql :large (habitat-fitter 20)))
  (is (eql :medium (habitat-fitter 19)))
  (is (eql :medium (habitat-fitter 10)))
  (is (eql :small (habitat-fitter 9)))
  (is (eql :small (habitat-fitter 1)))
  (is (eql :just-your-imagination (habitat-fitter 0)))
  (is (eql :just-your-imagination (habitat-fitter -5))))

(test we-feast "Determines whether the food-bowl needs refilling from its fullness"
  (is (string= "It's feeding time!" (feeding-time-p 10)))
  (is (string= "All is well." (feeding-time-p 36)))
  (is (string= "All is well." (feeding-time-p 74)))
  (is (string= "It's feeding time!" (feeding-time-p 3)))
  (is (string= "All is well." (feeding-time-p 90))))

(test code-of-conduct "Is the given action unsuitable for the given pet?"
  (is-false (pet "Cat"))
  (is-false (pet "Dog"))
  (is-true (pet "Fish"))
  (is-false (pet "Rabbit"))
  (is-false (pet "Bird"))

  (is-true (play-fetch "Cat"))
  (is-false (play-fetch "Dog"))
  (is-true (play-fetch "Fish"))
  (is-true (play-fetch "Rabbit"))
  (is-true (play-fetch "Bird")))

(defun run-tests (&optional (test-or-suite 'pal-picker-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
