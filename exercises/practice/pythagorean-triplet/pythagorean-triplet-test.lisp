;; Ensures that pythagorean-triplet.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "pythagorean-triplet")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from pythagorean-triplet and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :pythagorean-triplet-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :pythagorean-triplet-test)

;; Define and enter a new FiveAM test-suite
(def-suite* pythagorean-triplet-suite)

(test triplets-whose-sum-is-12
    (let ((n 12))
      (is (equal '((3 4 5)) (pythagorean-triplet:triplets-with-sum n)))))

(test triplets-whose-sum-is-108
    (let ((n 108))
      (is (equal '((27 36 45)) (pythagorean-triplet:triplets-with-sum n)))))

(test triplets-whose-sum-is-1000
    (let ((n 1000))
      (is (equal '((200 375 425)) (pythagorean-triplet:triplets-with-sum n)))))

(test no-matching-triplets-for-1001
    (let ((n 1001))
      (is (equal '() (pythagorean-triplet:triplets-with-sum n)))))

(test returns-all-matching-triplets
    (let ((n 90))
      (is (equal '((9 40 41) (15 36 39)) (pythagorean-triplet:triplets-with-sum n)))))

(test several-matching-triplets
    (let ((n 840)
          (result '((40 399 401)
                    (56 390 394)
                    (105 360 375)
                    (120 350 370)
                    (140 336 364)
                    (168 315 357)
                    (210 280 350)
                    (240 252 348))))
      (is (equal result (pythagorean-triplet:triplets-with-sum n)))))

(test triplets-for-large-number
    (let ((n 30000)
          (result '((1200 14375 14425)
                    (1875 14000 14125)
                    (5000 12000 13000)
                    (6000 11250 12750)
                    (7500 10000 12500))))
      (is (equal result (pythagorean-triplet:triplets-with-sum n)))))

(defun run-tests (&optional (test-or-suite 'pythagorean-triplet-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
