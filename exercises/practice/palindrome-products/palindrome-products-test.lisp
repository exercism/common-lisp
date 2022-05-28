;; Ensures that palindrome-products.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "palindrome-products")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from palindrome-products and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :palindrome-products-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :palindrome-products-test)

;; Define and enter a new FiveAM test-suite
(def-suite* palindrome-products-suite)

(test find-the-smallest-palindrome-from-single-digit-factors
    (let ((min-factor 1)
          (max-factor 9)
          (palindrome 1)
          (factors '((1 1))))
      (is (multiple-value-bind (p f) (palindrome-products:smallest min-factor max-factor)
                               (and (eql p palindrome) (equal f factors))))))

(test find-the-largest-palindrome-from-single-digit-factors
    (let ((min-factor 1)
          (max-factor 9)
          (palindrome 9)
          (factors '((1 9) (3 3))))
      (is (multiple-value-bind (p f) (palindrome-products:largest min-factor max-factor)
                               (and (eql p palindrome) (equal f factors))))))

(test find-the-smallest-palindrome-from-double-digit-factors
    (let ((min-factor 10)
          (max-factor 99)
          (palindrome 121)
          (factors '((11 11))))
      (is (multiple-value-bind (p f) (palindrome-products:smallest min-factor max-factor)
                               (and (eql p palindrome) (equal f factors))))))

(test find-the-largest-palindrome-from-double-digit-factors
    (let ((min-factor 10)
          (max-factor 99)
          (palindrome 9009)
          (factors '((91 99))))
      (is (multiple-value-bind (p f) (palindrome-products:largest min-factor max-factor)
                               (and (eql p palindrome) (equal f factors))))))

(test find-the-smallest-palindrome-from-triple-digit-factors
    (let ((min-factor 100)
          (max-factor 999)
          (palindrome 10201)
          (factors '((101 101))))
      (is (multiple-value-bind (p f) (palindrome-products:smallest min-factor max-factor)
                               (and (eql p palindrome) (equal f factors))))))

(test find-the-largest-palindrome-from-triple-digit-factors
    (let ((min-factor 100)
          (max-factor 999)
          (palindrome 906609)
          (factors '((913 993))))
      (is (multiple-value-bind (p f) (palindrome-products:largest min-factor max-factor)
                               (and (eql p palindrome) (equal f factors))))))

(test find-the-smallest-palindrome-from-four-digit-factors
    (let ((min-factor 1000)
          (max-factor 9999)
          (palindrome 1002001)
          (factors '((1001 1001))))
      (is (multiple-value-bind (p f) (palindrome-products:smallest min-factor max-factor)
                               (and (eql p palindrome) (equal f factors))))))

(test find-the-largest-palindrome-from-four-digit-factors
    (let ((min-factor 1000)
          (max-factor 9999)
          (palindrome 99000099)
          (factors '((9901 9999))))
      (is (multiple-value-bind (p f) (palindrome-products:largest min-factor max-factor)
                               (and (eql p palindrome) (equal f factors))))))

(test empty-result-for-smallest-if-no-palindrome-in-the-range
    (let ((min-factor 1002)
          (max-factor 1003)
          (palindrome NIL)
          (factors '()))
      (is (multiple-value-bind (p f) (palindrome-products:smallest min-factor max-factor)
                               (and (eql p palindrome) (equal f factors))))))

(test empty-result-for-largest-if-no-palindrome-in-the-range
    (let ((min-factor 15)
          (max-factor 15)
          (palindrome NIL)
          (factors '()))
      (is (multiple-value-bind (p f) (palindrome-products:largest min-factor max-factor)
                               (and (eql p palindrome) (equal f factors))))))

(test error-result-for-smallest-if-min-is-more-than-max
    (let ((min-factor 10000)
          (max-factor 1))
      (is (eql NIL (palindrome-products:smallest min-factor max-factor)))))

(test error-result-for-largest-if-min-is-more-than-max
    (let ((min-factor 2)
          (max-factor 1))
      (is (eql NIL (palindrome-products:largest min-factor max-factor)))))

(defun run-tests (&optional (test-or-suite 'palindrome-products-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
