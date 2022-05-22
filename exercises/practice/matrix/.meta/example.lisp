(defpackage :matrix
  (:use :cl)
  (:export :row
           :column))

(in-package :matrix)

(defun split-string (str split-char)
  (unless (zerop (length str))
    (let* ((word (subseq str 0 (position split-char str)))
           (rest-str (string-left-trim (list split-char) (subseq str (length word)))))
      (cons word (split-string rest-str split-char)))))

(defun string-row-to-list (string-row &optional (start-at 0))
  (multiple-value-bind (num new-start) (parse-integer string-row :junk-allowed t :start start-at)
                       (when num
                         (cons num (string-row-to-list string-row new-start)))))

(defun convert-to-array (input-matrix)
  (let* ((string-rows (split-string input-matrix #\newline))
         (nested-list (loop for row in string-rows collect (string-row-to-list row)))
         (rows (length nested-list))
         (columns (length (car nested-list))))
    (make-array (list rows columns) :initial-contents nested-list)))

(defun row (input-matrix index)
  (let ((2d-array (convert-to-array input-matrix)))
    (loop for i from 0 below (array-dimension 2d-array 1)
      collect (aref 2d-array (1- index) i))))

(defun column (input-matrix index)
  (let ((2d-array (convert-to-array input-matrix)))
    (loop for i from 0 below (array-dimension 2d-array 0)
      collect (aref 2d-array i (1- index)))))
