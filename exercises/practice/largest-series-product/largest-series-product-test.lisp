;; Ensures that largest-series-product.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "largest-series-product")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from largest-series-product and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :largest-series-product-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :largest-series-product-test)

;; Define and enter a new FiveAM test-suite
(def-suite* largest-series-product-suite)

(test finds-the-largest-product-if-span-equals-length
    (let ((digits "29")
          (span 2))
     (is (eql 18 (largest-series-product:largest-product digits span)))))

(test can-find-the-largest-product-of-2-with-numbers-in-order
    (let ((digits "0123456789")
          (span 2))
     (is (eql 72 (largest-series-product:largest-product digits span)))))

(test can-find-the-largest-product-of-2
    (let ((digits "576802143")
          (span 2))
     (is (eql 48 (largest-series-product:largest-product digits span)))))

(test can-find-the-largest-product-of-3-with-numbers-in-order
    (let ((digits "0123456789")
          (span 3))
     (is (eql 504 (largest-series-product:largest-product digits span)))))

(test can-find-the-largest-product-of-3
    (let ((digits "1027839564")
          (span 3))
     (is (eql 270 (largest-series-product:largest-product digits span)))))

(test can-find-the-largest-product-of-5-with-numbers-in-order
    (let ((digits "0123456789")
          (span 5))
     (is (eql 15120 (largest-series-product:largest-product digits span)))))

(test can-get-the-largest-product-of-a-big-number
    (let ((digits "73167176531330624919225119674426574742355349194934")
          (span 6))
     (is (eql 23520 (largest-series-product:largest-product digits span)))))

(test reports-zero-if-the-only-digits-are-zero
    (let ((digits "0000")
          (span 2))
     (is (eql 0 (largest-series-product:largest-product digits span)))))

(test reports-zero-if-all-spans-include-zero
    (let ((digits "99099")
          (span 3))
     (is (eql 0 (largest-series-product:largest-product digits span)))))

(test rejects-span-longer-than-string-length
    (let ((digits "123")
          (span 4))
     (is (eql NIL (largest-series-product:largest-product digits span)))))

(test reports-1-for-empty-string-and-empty-product
    (let ((digits "")
          (span 0))
     (is (eql 1 (largest-series-product:largest-product digits span)))))

(test reports-1-for-nonempty-string-and-empty-product
    (let ((digits "123")
          (span 0))
     (is (eql 1 (largest-series-product:largest-product digits span)))))

(test rejects-empty-string-and-nonzero-span
    (let ((digits "")
          (span 1))
     (is (eql NIL (largest-series-product:largest-product digits span)))))

(test rejects-invalid-character-in-digits
    (let ((digits "1234a5")
          (span 2))
     (is (eql NIL (largest-series-product:largest-product digits span)))))

(test rejects-negative-span
    (let ((digits "12345")
          (span -1))
     (is (eql NIL (largest-series-product:largest-product digits span)))))

(test rejects-negative-span
    (let ((digits "12345")
          (span -1))
     (is (eql NIL (largest-series-product:largest-product digits span)))))

(defun run-tests (&optional (test-or-suite 'largest-series-product-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
