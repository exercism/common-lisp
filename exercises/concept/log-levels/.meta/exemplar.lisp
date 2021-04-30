(defpackage :log-levels
  (:use :cl)
  (:export :log-message :log-severity :log-format))

(in-package :log-levels)

(defun log-message (log-string)
  (subseq log-string 8))

(defun log-severity (log-string)
  (let ((level (subseq log-string 0 6)))
    (cond ((string-equal level "[info]") :everything-ok)
          ((string-equal level "[warn]") :getting-worried)
          ((string-equal level "[ohno]") :run-for-cover))))

(defun log-format (log-string)
  (let ((message (log-message log-string))
        (severity (log-severity log-string)))
    (case severity
      (:everything-ok (string-downcase message))
      (:getting-worried (string-capitalize message))
      (:run-for-cover (string-upcase message)))))
