;; Ensures that proverb.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "proverb")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from proverb and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :proverb-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :proverb-test)

;; Define and enter a new FiveAM test-suite
(def-suite* proverb-suite)

(test zero-pieces
    (let ((strings '()))
      (is (string= "" (proverb:recite strings)))))

(test one-piece
    (let ((strings '("nail"))
          (result "And all for the want of a nail."))
      (is (string= result (proverb:recite strings)))))

(test two-pieces
    (let ((strings '("nail" "shoe"))
          (result (format nil "~{~A~^~%~}" '("For want of a nail the shoe was lost."
                                             "And all for the want of a nail."))))
      (is (string= result (proverb:recite strings)))))

(test three-pieces
    (let ((strings '("nail" "shoe" "horse"))
          (result (format nil "~{~A~^~%~}" '("For want of a nail the shoe was lost."
                                             "For want of a shoe the horse was lost."
                                             "And all for the want of a nail."))))
      (is (string= result (proverb:recite strings)))))

(test full-proverb
    (let ((strings '("nail" "shoe" "horse" "rider" "message" "battle" "kingdom"))
          (result (format nil "~{~A~^~%~}" '("For want of a nail the shoe was lost."
                                             "For want of a shoe the horse was lost."
                                             "For want of a horse the rider was lost."
                                             "For want of a rider the message was lost."
                                             "For want of a message the battle was lost."
                                             "For want of a battle the kingdom was lost."
                                             "And all for the want of a nail."))))
      (is (string= result (proverb:recite strings)))))

(test four-pieces-modernized
    (let ((strings '("pin" "gun" "soldier" "battle"))
          (result (format nil "~{~A~^~%~}" '("For want of a pin the gun was lost."
                                             "For want of a gun the soldier was lost."
                                             "For want of a soldier the battle was lost."
                                             "And all for the want of a pin."))))
      (is (string= result (proverb:recite strings)))))

(defun run-tests (&optional (test-or-suite 'proverb-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
