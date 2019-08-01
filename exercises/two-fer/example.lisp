(in-package #:cl-user)
(defpackage #:two-fer
  (:use #:cl)
  (:export #:twofer))
(in-package #:two-fer)

(defun twofer (name)
  (format nil "One for ~a, one for me." (if (or (null name) (string= name "")) "you" name)))
