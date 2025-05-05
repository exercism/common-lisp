(defpackage :acronym
  (:use :cl)
  (:export :acronym))

(in-package :acronym)

(defun acronym (phrase)
  (let ((chars ())
        (inside-word nil))
    (loop for char across phrase
          do (cond
               ((eql char #\')
                nil)
               ((and (alpha-char-p char) (not inside-word))
                (push (char-upcase char) chars)
                (setf inside-word t))
               ((not (alpha-char-p char))
                (setf inside-word nil))))
    (format nil "~{~A~}" (reverse chars))))