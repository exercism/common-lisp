(defpackage :gigasecond-anniversary
  (:use :cl)
  (:export :from))

(in-package :gigasecond-anniversary)

(defun from (year month day hour minute second)
  (reverse
   (subseq
    (multiple-value-list
     (let ((TZ 0))
       (decode-universal-time
        (+ (encode-universal-time second minute hour day month year TZ)
           (expt 10 9))
        TZ)))
    0 6)))
