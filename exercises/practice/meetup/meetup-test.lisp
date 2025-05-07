;;; Ensures that meetup.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "meetup")
  (quicklisp-client:quickload :fiveam))

;; Defines the testing package with symbols from meetup and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :meetup-test
  (:use :cl :fiveam)
  (:export :run-tests))

;; Enter the testing package
(in-package :meetup-test)

;; Define and enter a new FiveAM test-suite
(def-suite* meetup-suite)

(test when-teenth-monday-is-the-13th-the-first-day-of-the-teenth-week
    (let ((month 5)
          (year 2013)
          (dayofweek :monday)
          (week :teenth))
      (is (equal '(2013 5 13) (meetup:meetup month year dayofweek week)))))

(test when-teenth-monday-is-the-19th-the-last-day-of-the-teenth-week
    (let ((month 8)
          (year 2013)
          (dayofweek :monday)
          (week :teenth))
      (is (equal '(2013 8 19) (meetup:meetup month year dayofweek week)))))

(test when-teenth-monday-is-some-day-in-the-middle-of-the-teenth-week
    (let ((month 9)
          (year 2013)
          (dayofweek :monday)
          (week :teenth))
      (is (equal '(2013 9 16) (meetup:meetup month year dayofweek week)))))

(test when-teenth-tuesday-is-the-19th-the-last-day-of-the-teenth-week
    (let ((month 3)
          (year 2013)
          (dayofweek :tuesday)
          (week :teenth))
      (is (equal '(2013 3 19) (meetup:meetup month year dayofweek week)))))

(test when-teenth-tuesday-is-some-day-in-the-middle-of-the-teenth-week
    (let ((month 4)
          (year 2013)
          (dayofweek :tuesday)
          (week :teenth))
      (is (equal '(2013 4 16) (meetup:meetup month year dayofweek week)))))

(test when-teenth-tuesday-is-the-13th-the-first-day-of-the-teenth-week
    (let ((month 8)
          (year 2013)
          (dayofweek :tuesday)
          (week :teenth))
      (is (equal '(2013 8 13) (meetup:meetup month year dayofweek week)))))

(test when-teenth-wednesday-is-some-day-in-the-middle-of-the-teenth-week
    (let ((month 1)
          (year 2013)
          (dayofweek :wednesday)
          (week :teenth))
      (is (equal '(2013 1 16) (meetup:meetup month year dayofweek week)))))

(test when-teenth-wednesday-is-the-13th-the-first-day-of-the-teenth-week
    (let ((month 2)
          (year 2013)
          (dayofweek :wednesday)
          (week :teenth))
      (is (equal '(2013 2 13) (meetup:meetup month year dayofweek week)))))

(test when-teenth-wednesday-is-the-19th-the-last-day-of-the-teenth-week
    (let ((month 6)
          (year 2013)
          (dayofweek :wednesday)
          (week :teenth))
      (is (equal '(2013 6 19) (meetup:meetup month year dayofweek week)))))

(test when-teenth-thursday-is-some-day-in-the-middle-of-the-teenth-week
    (let ((month 5)
          (year 2013)
          (dayofweek :thursday)
          (week :teenth))
      (is (equal '(2013 5 16) (meetup:meetup month year dayofweek week)))))

(test when-teenth-thursday-is-the-13th-the-first-day-of-the-teenth-week
    (let ((month 6)
          (year 2013)
          (dayofweek :thursday)
          (week :teenth))
      (is (equal '(2013 6 13) (meetup:meetup month year dayofweek week)))))

(test when-teenth-thursday-is-the-19th-the-last-day-of-the-teenth-week
    (let ((month 9)
          (year 2013)
          (dayofweek :thursday)
          (week :teenth))
      (is (equal '(2013 9 19) (meetup:meetup month year dayofweek week)))))

(test when-teenth-friday-is-the-19th-the-last-day-of-the-teenth-week
    (let ((month 4)
          (year 2013)
          (dayofweek :friday)
          (week :teenth))
      (is (equal '(2013 4 19) (meetup:meetup month year dayofweek week)))))

(test when-teenth-friday-is-some-day-in-the-middle-of-the-teenth-week
    (let ((month 8)
          (year 2013)
          (dayofweek :friday)
          (week :teenth))
      (is (equal '(2013 8 16) (meetup:meetup month year dayofweek week)))))

(test when-teenth-friday-is-the-13th-the-first-day-of-the-teenth-week
    (let ((month 9)
          (year 2013)
          (dayofweek :friday)
          (week :teenth))
      (is (equal '(2013 9 13) (meetup:meetup month year dayofweek week)))))

(test when-teenth-saturday-is-some-day-in-the-middle-of-the-teenth-week
    (let ((month 2)
          (year 2013)
          (dayofweek :saturday)
          (week :teenth))
      (is (equal '(2013 2 16) (meetup:meetup month year dayofweek week)))))

(test when-teenth-saturday-is-the-13th-the-first-day-of-the-teenth-week
    (let ((month 4)
          (year 2013)
          (dayofweek :saturday)
          (week :teenth))
      (is (equal '(2013 4 13) (meetup:meetup month year dayofweek week)))))

(test when-teenth-saturday-is-the-19th-the-last-day-of-the-teenth-week
    (let ((month 10)
          (year 2013)
          (dayofweek :saturday)
          (week :teenth))
      (is (equal '(2013 10 19) (meetup:meetup month year dayofweek week)))))

(test when-teenth-sunday-is-the-19th-the-last-day-of-the-teenth-week
    (let ((month 5)
          (year 2013)
          (dayofweek :sunday)
          (week :teenth))
      (is (equal '(2013 5 19) (meetup:meetup month year dayofweek week)))))

(test when-teenth-sunday-is-some-day-in-the-middle-of-the-teenth-week
    (let ((month 6)
          (year 2013)
          (dayofweek :sunday)
          (week :teenth))
      (is (equal '(2013 6 16) (meetup:meetup month year dayofweek week)))))

(test when-teenth-sunday-is-the-13th-the-first-day-of-the-teenth-week
    (let ((month 10)
          (year 2013)
          (dayofweek :sunday)
          (week :teenth))
      (is (equal '(2013 10 13) (meetup:meetup month year dayofweek week)))))

(test when-first-monday-is-some-day-in-the-middle-of-the-first-week
    (let ((month 3)
          (year 2013)
          (dayofweek :monday)
          (week :first))
      (is (equal '(2013 3 4) (meetup:meetup month year dayofweek week)))))

(test when-first-monday-is-the-1st-the-first-day-of-the-first-week
    (let ((month 4)
          (year 2013)
          (dayofweek :monday)
          (week :first))
      (is (equal '(2013 4 1) (meetup:meetup month year dayofweek week)))))

(test when-first-tuesday-is-the-7th-the-last-day-of-the-first-week
    (let ((month 5)
          (year 2013)
          (dayofweek :tuesday)
          (week :first))
      (is (equal '(2013 5 7) (meetup:meetup month year dayofweek week)))))

(test when-first-tuesday-is-some-day-in-the-middle-of-the-first-week
    (let ((month 6)
          (year 2013)
          (dayofweek :tuesday)
          (week :first))
      (is (equal '(2013 6 4) (meetup:meetup month year dayofweek week)))))

(test when-first-wednesday-is-some-day-in-the-middle-of-the-first-week
    (let ((month 7)
          (year 2013)
          (dayofweek :wednesday)
          (week :first))
      (is (equal '(2013 7 3) (meetup:meetup month year dayofweek week)))))

(test when-first-wednesday-is-the-7th-the-last-day-of-the-first-week
    (let ((month 8)
          (year 2013)
          (dayofweek :wednesday)
          (week :first))
      (is (equal '(2013 8 7) (meetup:meetup month year dayofweek week)))))

(test when-first-thursday-is-some-day-in-the-middle-of-the-first-week
    (let ((month 9)
          (year 2013)
          (dayofweek :thursday)
          (week :first))
      (is (equal '(2013 9 5) (meetup:meetup month year dayofweek week)))))

(test when-first-thursday-is-another-day-in-the-middle-of-the-first-week
    (let ((month 10)
          (year 2013)
          (dayofweek :thursday)
          (week :first))
      (is (equal '(2013 10 3) (meetup:meetup month year dayofweek week)))))

(test when-first-friday-is-the-1st-the-first-day-of-the-first-week
    (let ((month 11)
          (year 2013)
          (dayofweek :friday)
          (week :first))
      (is (equal '(2013 11 1) (meetup:meetup month year dayofweek week)))))

(test when-first-friday-is-some-day-in-the-middle-of-the-first-week
    (let ((month 12)
          (year 2013)
          (dayofweek :friday)
          (week :first))
      (is (equal '(2013 12 6) (meetup:meetup month year dayofweek week)))))

(test when-first-saturday-is-some-day-in-the-middle-of-the-first-week
    (let ((month 1)
          (year 2013)
          (dayofweek :saturday)
          (week :first))
      (is (equal '(2013 1 5) (meetup:meetup month year dayofweek week)))))

(test when-first-saturday-is-another-day-in-the-middle-of-the-first-week
    (let ((month 2)
          (year 2013)
          (dayofweek :saturday)
          (week :first))
      (is (equal '(2013 2 2) (meetup:meetup month year dayofweek week)))))

(test when-first-sunday-is-some-day-in-the-middle-of-the-first-week
    (let ((month 3)
          (year 2013)
          (dayofweek :sunday)
          (week :first))
      (is (equal '(2013 3 3) (meetup:meetup month year dayofweek week)))))

(test when-first-sunday-is-the-7th-the-last-day-of-the-first-week
    (let ((month 4)
          (year 2013)
          (dayofweek :sunday)
          (week :first))
      (is (equal '(2013 4 7) (meetup:meetup month year dayofweek week)))))

(test when-second-monday-is-some-day-in-the-middle-of-the-second-week
    (let ((month 3)
          (year 2013)
          (dayofweek :monday)
          (week :second))
      (is (equal '(2013 3 11) (meetup:meetup month year dayofweek week)))))

(test when-second-monday-is-the-8th-the-first-day-of-the-second-week
    (let ((month 4)
          (year 2013)
          (dayofweek :monday)
          (week :second))
      (is (equal '(2013 4 8) (meetup:meetup month year dayofweek week)))))

(test when-second-tuesday-is-the-14th-the-last-day-of-the-second-week
    (let ((month 5)
          (year 2013)
          (dayofweek :tuesday)
          (week :second))
      (is (equal '(2013 5 14) (meetup:meetup month year dayofweek week)))))

(test when-second-tuesday-is-some-day-in-the-middle-of-the-second-week
    (let ((month 6)
          (year 2013)
          (dayofweek :tuesday)
          (week :second))
      (is (equal '(2013 6 11) (meetup:meetup month year dayofweek week)))))

(test when-second-wednesday-is-some-day-in-the-middle-of-the-second-week
    (let ((month 7)
          (year 2013)
          (dayofweek :wednesday)
          (week :second))
      (is (equal '(2013 7 10) (meetup:meetup month year dayofweek week)))))

(test when-second-wednesday-is-the-14th-the-last-day-of-the-second-week
    (let ((month 8)
          (year 2013)
          (dayofweek :wednesday)
          (week :second))
      (is (equal '(2013 8 14) (meetup:meetup month year dayofweek week)))))

(test when-second-thursday-is-some-day-in-the-middle-of-the-second-week
    (let ((month 9)
          (year 2013)
          (dayofweek :thursday)
          (week :second))
      (is (equal '(2013 9 12) (meetup:meetup month year dayofweek week)))))

(test when-second-thursday-is-another-day-in-the-middle-of-the-second-week
    (let ((month 10)
          (year 2013)
          (dayofweek :thursday)
          (week :second))
      (is (equal '(2013 10 10) (meetup:meetup month year dayofweek week)))))

(test when-second-friday-is-the-8th-the-first-day-of-the-second-week
    (let ((month 11)
          (year 2013)
          (dayofweek :friday)
          (week :second))
      (is (equal '(2013 11 8) (meetup:meetup month year dayofweek week)))))

(test when-second-friday-is-some-day-in-the-middle-of-the-second-week
    (let ((month 12)
          (year 2013)
          (dayofweek :friday)
          (week :second))
      (is (equal '(2013 12 13) (meetup:meetup month year dayofweek week)))))

(test when-second-saturday-is-some-day-in-the-middle-of-the-second-week
    (let ((month 1)
          (year 2013)
          (dayofweek :saturday)
          (week :second))
      (is (equal '(2013 1 12) (meetup:meetup month year dayofweek week)))))

(test when-second-saturday-is-another-day-in-the-middle-of-the-second-week
    (let ((month 2)
          (year 2013)
          (dayofweek :saturday)
          (week :second))
      (is (equal '(2013 2 9) (meetup:meetup month year dayofweek week)))))

(test when-second-sunday-is-some-day-in-the-middle-of-the-second-week
    (let ((month 3)
          (year 2013)
          (dayofweek :sunday)
          (week :second))
      (is (equal '(2013 3 10) (meetup:meetup month year dayofweek week)))))

(test when-second-sunday-is-the-14th-the-last-day-of-the-second-week
    (let ((month 4)
          (year 2013)
          (dayofweek :sunday)
          (week :second))
      (is (equal '(2013 4 14) (meetup:meetup month year dayofweek week)))))

(test when-third-monday-is-some-day-in-the-middle-of-the-third-week
    (let ((month 3)
          (year 2013)
          (dayofweek :monday)
          (week :third))
      (is (equal '(2013 3 18) (meetup:meetup month year dayofweek week)))))

(test when-third-monday-is-the-15th-the-first-day-of-the-third-week
    (let ((month 4)
          (year 2013)
          (dayofweek :monday)
          (week :third))
      (is (equal '(2013 4 15) (meetup:meetup month year dayofweek week)))))

(test when-third-tuesday-is-the-21st-the-last-day-of-the-third-week
    (let ((month 5)
          (year 2013)
          (dayofweek :tuesday)
          (week :third))
      (is (equal '(2013 5 21) (meetup:meetup month year dayofweek week)))))

(test when-third-tuesday-is-some-day-in-the-middle-of-the-third-week
    (let ((month 6)
          (year 2013)
          (dayofweek :tuesday)
          (week :third))
      (is (equal '(2013 6 18) (meetup:meetup month year dayofweek week)))))

(test when-third-wednesday-is-some-day-in-the-middle-of-the-third-week
    (let ((month 7)
          (year 2013)
          (dayofweek :wednesday)
          (week :third))
      (is (equal '(2013 7 17) (meetup:meetup month year dayofweek week)))))

(test when-third-wednesday-is-the-21st-the-last-day-of-the-third-week
    (let ((month 8)
          (year 2013)
          (dayofweek :wednesday)
          (week :third))
      (is (equal '(2013 8 21) (meetup:meetup month year dayofweek week)))))

(test when-third-thursday-is-some-day-in-the-middle-of-the-third-week
    (let ((month 9)
          (year 2013)
          (dayofweek :thursday)
          (week :third))
      (is (equal '(2013 9 19) (meetup:meetup month year dayofweek week)))))

(test when-third-thursday-is-another-day-in-the-middle-of-the-third-week
    (let ((month 10)
          (year 2013)
          (dayofweek :thursday)
          (week :third))
      (is (equal '(2013 10 17) (meetup:meetup month year dayofweek week)))))

(test when-third-friday-is-the-15th-the-first-day-of-the-third-week
    (let ((month 11)
          (year 2013)
          (dayofweek :friday)
          (week :third))
      (is (equal '(2013 11 15) (meetup:meetup month year dayofweek week)))))

(test when-third-friday-is-some-day-in-the-middle-of-the-third-week
    (let ((month 12)
          (year 2013)
          (dayofweek :friday)
          (week :third))
      (is (equal '(2013 12 20) (meetup:meetup month year dayofweek week)))))

(test when-third-saturday-is-some-day-in-the-middle-of-the-third-week
    (let ((month 1)
          (year 2013)
          (dayofweek :saturday)
          (week :third))
      (is (equal '(2013 1 19) (meetup:meetup month year dayofweek week)))))

(test when-third-saturday-is-another-day-in-the-middle-of-the-third-week
    (let ((month 2)
          (year 2013)
          (dayofweek :saturday)
          (week :third))
      (is (equal '(2013 2 16) (meetup:meetup month year dayofweek week)))))

(test when-third-sunday-is-some-day-in-the-middle-of-the-third-week
    (let ((month 3)
          (year 2013)
          (dayofweek :sunday)
          (week :third))
      (is (equal '(2013 3 17) (meetup:meetup month year dayofweek week)))))

(test when-third-sunday-is-the-21st-the-last-day-of-the-third-week
    (let ((month 4)
          (year 2013)
          (dayofweek :sunday)
          (week :third))
      (is (equal '(2013 4 21) (meetup:meetup month year dayofweek week)))))

(test when-fourth-monday-is-some-day-in-the-middle-of-the-fourth-week
    (let ((month 3)
          (year 2013)
          (dayofweek :monday)
          (week :fourth))
      (is (equal '(2013 3 25) (meetup:meetup month year dayofweek week)))))

(test when-fourth-monday-is-the-22nd-the-first-day-of-the-fourth-week
    (let ((month 4)
          (year 2013)
          (dayofweek :monday)
          (week :fourth))
      (is (equal '(2013 4 22) (meetup:meetup month year dayofweek week)))))

(test when-fourth-tuesday-is-the-28th-the-last-day-of-the-fourth-week
    (let ((month 5)
          (year 2013)
          (dayofweek :tuesday)
          (week :fourth))
      (is (equal '(2013 5 28) (meetup:meetup month year dayofweek week)))))

(test when-fourth-tuesday-is-some-day-in-the-middle-of-the-fourth-week
    (let ((month 6)
          (year 2013)
          (dayofweek :tuesday)
          (week :fourth))
      (is (equal '(2013 6 25) (meetup:meetup month year dayofweek week)))))

(test when-fourth-wednesday-is-some-day-in-the-middle-of-the-fourth-week
    (let ((month 7)
          (year 2013)
          (dayofweek :wednesday)
          (week :fourth))
      (is (equal '(2013 7 24) (meetup:meetup month year dayofweek week)))))

(test when-fourth-wednesday-is-the-28th-the-last-day-of-the-fourth-week
    (let ((month 8)
          (year 2013)
          (dayofweek :wednesday)
          (week :fourth))
      (is (equal '(2013 8 28) (meetup:meetup month year dayofweek week)))))

(test when-fourth-thursday-is-some-day-in-the-middle-of-the-fourth-week
    (let ((month 9)
          (year 2013)
          (dayofweek :thursday)
          (week :fourth))
      (is (equal '(2013 9 26) (meetup:meetup month year dayofweek week)))))

(test when-fourth-thursday-is-another-day-in-the-middle-of-the-fourth-week
    (let ((month 10)
          (year 2013)
          (dayofweek :thursday)
          (week :fourth))
      (is (equal '(2013 10 24) (meetup:meetup month year dayofweek week)))))

(test when-fourth-friday-is-the-22nd-the-first-day-of-the-fourth-week
    (let ((month 11)
          (year 2013)
          (dayofweek :friday)
          (week :fourth))
      (is (equal '(2013 11 22) (meetup:meetup month year dayofweek week)))))

(test when-fourth-friday-is-some-day-in-the-middle-of-the-fourth-week
    (let ((month 12)
          (year 2013)
          (dayofweek :friday)
          (week :fourth))
      (is (equal '(2013 12 27) (meetup:meetup month year dayofweek week)))))

(test when-fourth-saturday-is-some-day-in-the-middle-of-the-fourth-week
    (let ((month 1)
          (year 2013)
          (dayofweek :saturday)
          (week :fourth))
      (is (equal '(2013 1 26) (meetup:meetup month year dayofweek week)))))

(test when-fourth-saturday-is-another-day-in-the-middle-of-the-fourth-week
    (let ((month 2)
          (year 2013)
          (dayofweek :saturday)
          (week :fourth))
      (is (equal '(2013 2 23) (meetup:meetup month year dayofweek week)))))

(test when-fourth-sunday-is-some-day-in-the-middle-of-the-fourth-week
    (let ((month 3)
          (year 2013)
          (dayofweek :sunday)
          (week :fourth))
      (is (equal '(2013 3 24) (meetup:meetup month year dayofweek week)))))

(test when-fourth-sunday-is-the-28th-the-last-day-of-the-fourth-week
    (let ((month 4)
          (year 2013)
          (dayofweek :sunday)
          (week :fourth))
      (is (equal '(2013 4 28) (meetup:meetup month year dayofweek week)))))

(test last-monday-in-a-month-with-four-mondays
    (let ((month 3)
          (year 2013)
          (dayofweek :monday)
          (week :last))
      (is (equal '(2013 3 25) (meetup:meetup month year dayofweek week)))))

(test last-monday-in-a-month-with-five-mondays
    (let ((month 4)
          (year 2013)
          (dayofweek :monday)
          (week :last))
      (is (equal '(2013 4 29) (meetup:meetup month year dayofweek week)))))

(test last-tuesday-in-a-month-with-four-tuesdays
    (let ((month 5)
          (year 2013)
          (dayofweek :tuesday)
          (week :last))
      (is (equal '(2013 5 28) (meetup:meetup month year dayofweek week)))))

(test last-tuesday-in-another-month-with-four-tuesdays
    (let ((month 6)
          (year 2013)
          (dayofweek :tuesday)
          (week :last))
      (is (equal '(2013 6 25) (meetup:meetup month year dayofweek week)))))

(test last-wednesday-in-a-month-with-five-wednesdays
    (let ((month 7)
          (year 2013)
          (dayofweek :wednesday)
          (week :last))
      (is (equal '(2013 7 31) (meetup:meetup month year dayofweek week)))))

(test last-wednesday-in-a-month-with-four-wednesdays
    (let ((month 8)
          (year 2013)
          (dayofweek :wednesday)
          (week :last))
      (is (equal '(2013 8 28) (meetup:meetup month year dayofweek week)))))

(test last-thursday-in-a-month-with-four-thursdays
    (let ((month 9)
          (year 2013)
          (dayofweek :thursday)
          (week :last))
      (is (equal '(2013 9 26) (meetup:meetup month year dayofweek week)))))

(test last-thursday-in-a-month-with-five-thursdays
    (let ((month 10)
          (year 2013)
          (dayofweek :thursday)
          (week :last))
      (is (equal '(2013 10 31) (meetup:meetup month year dayofweek week)))))

(test last-friday-in-a-month-with-five-fridays
    (let ((month 11)
          (year 2013)
          (dayofweek :friday)
          (week :last))
      (is (equal '(2013 11 29) (meetup:meetup month year dayofweek week)))))

(test last-friday-in-a-month-with-four-fridays
    (let ((month 12)
          (year 2013)
          (dayofweek :friday)
          (week :last))
      (is (equal '(2013 12 27) (meetup:meetup month year dayofweek week)))))

(test last-saturday-in-a-month-with-four-saturdays
    (let ((month 1)
          (year 2013)
          (dayofweek :saturday)
          (week :last))
      (is (equal '(2013 1 26) (meetup:meetup month year dayofweek week)))))

(test last-saturday-in-another-month-with-four-saturdays
    (let ((month 2)
          (year 2013)
          (dayofweek :saturday)
          (week :last))
      (is (equal '(2013 2 23) (meetup:meetup month year dayofweek week)))))

(test last-sunday-in-a-month-with-five-sundays
    (let ((month 3)
          (year 2013)
          (dayofweek :sunday)
          (week :last))
      (is (equal '(2013 3 31) (meetup:meetup month year dayofweek week)))))

(test last-sunday-in-a-month-with-four-sundays
    (let ((month 4)
          (year 2013)
          (dayofweek :sunday)
          (week :last))
      (is (equal '(2013 4 28) (meetup:meetup month year dayofweek week)))))

(test when-last-wednesday-in-february-in-a-leap-year-is-the-29th
    (let ((month 2)
          (year 2012)
          (dayofweek :wednesday)
          (week :last))
      (is (equal '(2012 2 29) (meetup:meetup month year dayofweek week)))))

(test last-wednesday-in-december-that-is-also-the-last-day-of-the-year
    (let ((month 12)
          (year 2014)
          (dayofweek :wednesday)
          (week :last))
      (is (equal '(2014 12 31) (meetup:meetup month year dayofweek week)))))

(test when-last-sunday-in-february-in-a-non-leap-year-is-not-the-29th
    (let ((month 2)
          (year 2015)
          (dayofweek :sunday)
          (week :last))
      (is (equal '(2015 2 22) (meetup:meetup month year dayofweek week)))))

(test when-first-friday-is-the-7th-the-last-day-of-the-first-week
    (let ((month 12)
          (year 2012)
          (dayofweek :friday)
          (week :first))
      (is (equal '(2012 12 7) (meetup:meetup month year dayofweek week)))))

(defun run-tests (&optional (test-or-suite 'meetup-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))