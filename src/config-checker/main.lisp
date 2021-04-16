(in-package #:config-checker)

(define-condition config-check-failure (error) ())

(defparameter *checkers* nil)

(defun check-config ()
  (let ((config (track-config:read-config "./config.json")))
    (dolist (checker *checkers*)
      (format *debug-io* "~&Running Checker: ~S~&" checker)
      (funcall checker config))))

(defun ci-check-config ()
  "Version of CHECK-CONFIG for use in CI processes. Will exit with an error code."
  (handler-case (check-config)
    (error () (uiop:quit -1))))
