;; Ensures that line-up.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "line-up")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from line-up and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :line-up-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :line-up-test)

;; Define and enter a new FiveAM test-suite
(def-suite* line-up-suite)

(test format-smallest-non-exceptional-ordinal-numeral-4
    (let ((name "Gianna")
          (number 4)
          (result "Gianna, you are the 4th customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-greatest-single-digit-non-exceptional-ordinal-numeral-9
    (let ((name "Maarten")
          (number 9)
          (result "Maarten, you are the 9th customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-non-exceptional-ordinal-numeral-5
    (let ((name "Petronila")
          (number 5)
          (result "Petronila, you are the 5th customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-non-exceptional-ordinal-numeral-6
    (let ((name "Attakullakulla")
          (number 6)
          (result "Attakullakulla, you are the 6th customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-non-exceptional-ordinal-numeral-7
    (let ((name "Kate")
          (number 7)
          (result "Kate, you are the 7th customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-non-exceptional-ordinal-numeral-8
    (let ((name "Maximiliano")
          (number 8)
          (result "Maximiliano, you are the 8th customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-exceptional-ordinal-numeral-1
    (let ((name "Mary")
          (number 1)
          (result "Mary, you are the 1st customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-exceptional-ordinal-numeral-2
    (let ((name "Haruto")
          (number 2)
          (result "Haruto, you are the 2nd customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-exceptional-ordinal-numeral-3
    (let ((name "Henriette")
          (number 3)
          (result "Henriette, you are the 3rd customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-smallest-two-digit-non-exceptional-ordinal-numeral-10
    (let ((name "Alvarez")
          (number 10)
          (result "Alvarez, you are the 10th customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-non-exceptional-ordinal-numeral-11
    (let ((name "Jacqueline")
          (number 11)
          (result "Jacqueline, you are the 11th customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-non-exceptional-ordinal-numeral-12
    (let ((name "Juan")
          (number 12)
          (result "Juan, you are the 12th customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-non-exceptional-ordinal-numeral-13
    (let ((name "Patricia")
          (number 13)
          (result "Patricia, you are the 13th customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-exceptional-ordinal-numeral-21
    (let ((name "Washi")
          (number 21)
          (result "Washi, you are the 21st customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-exceptional-ordinal-numeral-62
    (let ((name "Nayra")
          (number 62)
          (result "Nayra, you are the 62nd customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-exceptional-ordinal-numeral-100
    (let ((name "John")
          (number 100)
          (result "John, you are the 100th customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-exceptional-ordinal-numeral-101
    (let ((name "Zeinab")
          (number 101)
          (result "Zeinab, you are the 101st customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-non-exceptional-ordinal-numeral-112
    (let ((name "Knud")
          (number 112)
          (result "Knud, you are the 112th customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(test format-exceptional-ordinal-numeral-123
    (let ((name "Yma")
          (number 123)
          (result "Yma, you are the 123rd customer we serve today. Thank you!"))
      (is (string= result (line-up:format name number)))))

(defun run-tests (&optional (test-or-suite 'line-up-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
