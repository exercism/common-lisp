;; Ensures that sieve.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "sieve")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from sieve and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :sieve-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :sieve-test)

;; Define and enter a new FiveAM test-suite
(def-suite* sieve-suite)

(test no-primes-under-two (is (equal 'nil (sieve:primes-to 1))))

(test find-first-prime (is (equal '(2) (sieve:primes-to 2))))

(test find-primes-up-to-10 (is (equal '(2 3 5 7) (sieve:primes-to 10))))

(test limit-is-prime (is (equal '(2 3 5 7 11 13) (sieve:primes-to 13))))

(test primes-below-1000
 (let ((primes-below-1000
        '(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89
          97 101 103 107 109 113 127 131 137 139 149 151 157 163 167 173 179
          181 191 193 197 199 211 223 227 229 233 239 241 251 257 263 269 271
          277 281 283 293 307 311 313 317 331 337 347 349 353 359 367 373 379
          383 389 397 401 409 419 421 431 433 439 443 449 457 461 463 467 479
          487 491 499 503 509 521 523 541 547 557 563 569 571 577 587 593 599
          601 607 613 617 619 631 641 643 647 653 659 661 673 677 683 691 701
          709 719 727 733 739 743 751 757 761 769 773 787 797 809 811 821 823
          827 829 839 853 857 859 863 877 881 883 887 907 911 919 929 937 941
          947 953 967 971 977 983 991 997)))
   (is (equal primes-below-1000 (sieve:primes-to 1000)))))

(defun run-tests (&optional (test-or-suite 'sieve-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
