(in-package :config-checker)

(define-condition config-check-failure (error) ())

(defparameter *checkers* nil)

(defun check-config ()
  (let ((config (track-config:read-config "./config.json")))
    (dolist (checker *checkers*)
      (format *debug-io* "~&Running Checker: ~S~&" checker)
      (funcall checker config))))
