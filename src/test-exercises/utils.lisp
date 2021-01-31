(in-package #:test-exercises)

(defun aget (key alist) (cdr (assoc key alist)))

(defun keywordize (str)
  (intern (string-upcase str) :keyword))
