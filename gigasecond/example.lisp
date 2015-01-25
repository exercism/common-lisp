(defpackage #:gigasecond
  (:use #:cl)
  (:export #:from))

(in-package #:gigasecond)

(defun from (year month day hour minute second)
  (reverse
   (subseq
    (multiple-value-list
     (decode-universal-time
      (+ (encode-universal-time second minute hour day month year)
	 (expt 10 9))))
    0 6)))
