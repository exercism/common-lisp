(defpackage #:meetup
  (:use #:common-lisp)
  (:export #:meetup))

(in-package #:meetup)

(defun day-of-week (day month year)
  (nth 6 (multiple-value-list
	  (decode-universal-time
	   (encode-universal-time 0 0 0 day month year)))))

(defun last-day-of (month year)
  (let ((month (if (= month 12) 1 (1+ month)))
	(year (if (= month 12) (1+ year) year)))
    (nth 3 (multiple-value-list
	    (decode-universal-time
	     (1- (encode-universal-time 0 0 0 1 month year)))))))

(defun find-dow-near-date (target-dow direction day month year)
  (let ((direction-factor (* 7 (ecase direction (:before -1) (:after 1))))
	(dow-of-day (day-of-week day month year)))
    (list year month (+ day (rem (+ (- target-dow dow-of-day)
				    direction-factor)
				 7)))))

(defvar +days-of-the-week+ '((:monday . 0)
			     (:tuesday . 1)
			     (:wednesday . 2)
			     (:thursday . 3)
			     (:friday . 4)
			     (:saturday . 5)
			     (:sunday . 6)))

(defvar +schedules+ '((:first . 1)
		      (:second . 8)
		      (:third . 15)
		      (:fourth . 22)
		      (:teenth . 13)))

(defun meetup (month year dow schedule)
  (let ((day-num (cdr (assoc dow +days-of-the-week+)))
	(schedule-offset (cdr (assoc schedule +schedules+))))
    (if (eq schedule :last)
	(find-dow-near-date day-num :before (last-day-of month year) month year)
	(find-dow-near-date day-num :after schedule-offset month year))))
