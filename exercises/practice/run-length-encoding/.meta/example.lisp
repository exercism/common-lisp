(defpackage :run-length-encoding
  (:use :cl)
  (:export :encode
           :decode))

(in-package :run-length-encoding)

(defun encode-chunk (len letter)
  (if (= 1 len)
    (string letter)
    (format nil "~A~A" len letter)))

(defun decode-chunk (num-string len letter)
  (if (zerop len)
    (string letter)
    (make-string (parse-integer num-string) :initial-element letter)))

(defun take-while (pred str)
  (loop for x across str
    while (funcall pred x)
    collect x into output
    finally (return (coerce output 'string))))

(defun encode (plain)
  (if (zerop (length plain))
    ""
    (let* ((letter (char plain 0))
           (len (length (take-while (lambda (c) (char= c letter)) plain))))
      (concatenate 'string (encode-chunk len letter) (encode (subseq plain len))))))

(defun decode (compressed)
  (if (zerop (length compressed))
    ""
    (let* ((num-string (take-while #'digit-char-p compressed))
           (len (length num-string))
           (letter (char compressed len)))
      (concatenate 'string (decode-chunk num-string len letter) (decode (subseq compressed (1+ len)))))))
