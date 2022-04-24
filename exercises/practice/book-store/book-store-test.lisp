;; Ensures that book-store.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "book-store")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from book-store and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :book-store-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :book-store-test)

;; Define and enter a new FiveAM test-suite
(def-suite* book-store-suite)

(test only-a-single-book
    (let ((basket '(1)))
     (is (eql 800 (book-store:calculate-price basket)))))

(test two-of-the-same-book
    (let ((basket '(2 2)))
     (is (eql 1600 (book-store:calculate-price basket)))))

(test empty-basket
    (let ((basket '()))
     (is (eql 0 (book-store:calculate-price basket)))))

(test two-different-books
    (let ((basket '(1 2)))
     (is (eql 1520 (book-store:calculate-price basket)))))

(test three-different-books
    (let ((basket '(1 2 3)))
     (is (eql 2160 (book-store:calculate-price basket)))))

(test four-different-books
    (let ((basket '(1 2 3 4)))
     (is (eql 2560 (book-store:calculate-price basket)))))

(test five-different-books
    (let ((basket '(1 2 3 4 5)))
     (is (eql 3000 (book-store:calculate-price basket)))))

(test two-groups-of-four-is-cheaper-than-group-of-five-plus-group-of-three
    (let ((basket '(1 1 2 2 3 3 4 5)))
     (is (eql 5120 (book-store:calculate-price basket)))))

(test two-groups-of-four-is-cheaper-than-groups-of-five-and-three
    (let ((basket '(1 1 2 3 4 4 5 5)))
     (is (eql 5120 (book-store:calculate-price basket)))))

(test group-of-four-plus-group-of-two-is-cheaper-than-two-groups-of-three
    (let ((basket '(1 1 2 2 3 4)))
     (is (eql 4080 (book-store:calculate-price basket)))))

(test two-each-of-first-4-books-and-1-copy-each-of-rest
    (let ((basket '(1 1 2 2 3 3 4 4 5)))
     (is (eql 5560 (book-store:calculate-price basket)))))

(test two-copies-of-each-book
    (let ((basket '(1 1 2 2 3 3 4 4 5 5)))
     (is (eql 6000 (book-store:calculate-price basket)))))

(test three-copies-of-first-book-and-2-each-of-remaining
    (let ((basket '(1 1 2 2 3 3 4 4 5 5 1)))
     (is (eql 6800 (book-store:calculate-price basket)))))

(test three-each-of-first-2-books-and-2-each-of-remaining-books
    (let ((basket '(1 1 2 2 3 3 4 4 5 5 1 2)))
     (is (eql 7520 (book-store:calculate-price basket)))))

(test four-groups-of-four-are-cheaper-than-two-groups-each-of-five-and-three
    (let ((basket '(1 1 2 2 3 3 4 5 1 1 2 2 3 3 4 5)))
     (is (eql 10240 (book-store:calculate-price basket)))))

(test check-that-groups-of-four-are-created-properly-even-when-there-are-more-groups-of-three-than-groups-of-five
    (let ((basket '(1 1 1 1 1 1 2 2 2 2 2 2 3 3 3 3 3 3 4 4 5 5)))
     (is (eql 14560 (book-store:calculate-price basket)))))

(test one-group-of-one-and-four-is-cheaper-than-one-group-of-two-and-three
    (let ((basket '(1 1 2 3 4)))
     (is (eql 3360 (book-store:calculate-price basket)))))

(test one-group-of-one-and-two-plus-three-groups-of-four-is-cheaper-than-one-group-of-each-size
    (let ((basket '(1 2 2 3 3 3 4 4 4 4 5 5 5 5 5)))
     (is (eql 10000 (book-store:calculate-price basket)))))

(defun run-tests (&optional (test-or-suite 'book-store-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
