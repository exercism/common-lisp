;; Ensures that prime-factors.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "prime-factors")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from prime-factors and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :prime-factors-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :prime-factors-test)

;; Define and enter a new FiveAM test-suite
(def-suite* prime-factors-suite)

(test one (is (equal 'nil (prime-factors:factors-of 1))))

(test two (is (equal '(2) (prime-factors:factors-of 2))))

(test three (is (equal '(3) (prime-factors:factors-of 3))))

(test four (is (equal '(2 2) (prime-factors:factors-of 4))))

(test six (is (equal '(2 3) (sort (prime-factors:factors-of 6) #'<))))

(test eight (is (equal '(2 2 2) (prime-factors:factors-of 8))))

(test nine (is (equal '(3 3) (prime-factors:factors-of 9))))

(test twenty-seven (is (equal '(3 3 3) (prime-factors:factors-of 27))))

(test six-hundred-twenty-five
 (is (equal '(5 5 5 5) (prime-factors:factors-of 625))))

(test a-large-number
 (is (equal '(5 17 23 461) (sort (prime-factors:factors-of 901255) #'<))))

(test a-huge-number
 (is
  (equal '(11 9539 894119) (sort (prime-factors:factors-of 93819012551) #'<))))

(test triple-squares-number
 (is (equal '(2 2 5 5 7 7) (sort (prime-factors:factors-of 4900) #'<))))

(test mersenne-composite-1
 (is (equal '(23 89) (sort (prime-factors:factors-of 2047) #'<))))

(test fermat-composite-1
 (is (equal '(641 6700417) (sort (prime-factors:factors-of 4294967297) #'<))))

(test weak-probable-prime
 (is (equal '(11 31) (sort (prime-factors:factors-of 341) #'<))))

(test strong-probable-prime
 (is (equal '(7 31 73) (sort (prime-factors:factors-of 15841) #'<))))

(test carmichael-small-1
 (is (equal '(3 11 17) (sort (prime-factors:factors-of 561) #'<))))

(test carmichael-small-2
 (is (equal '(11 13 17 31) (sort (prime-factors:factors-of 75361) #'<))))

(test pseudoprime-smallish
 (is
  (equal '(1303 16927 157543)
         (sort (prime-factors:factors-of 3474749660383) #'<))))

(defun run-tests (&optional (test-or-suite 'prime-factors-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
