(in-package #:config-checker)

(define-condition config-check-failure (error) ())

(defun each-concept-has-a-directory (config)
  (let* ((concepts (mapcar #'(lambda (h) (gethash "slug" h)) (gethash "concepts" config)))
         (bad-concepts
           (remove-if #'(lambda (c) (probe-file (merge-pathnames c "./concepts/"))) concepts)))
    (when bad-concepts
      (dolist (c bad-concepts)
        (format *error-output* "Concept: ~S does not have a directory~&" c))
      (error 'config-check-failure))))

(defparameter *checkers* (list #'each-concept-has-a-directory))

(defun check-config ()
  (let ((config (yason:parse (truename "./config.json"))))
    (dolist (checker *checkers*)
      (funcall checker config))))

(defun ci-check-config ()
  "Version of CHECK-CONFIG for use in CI processes. Will exit with an error code."
  (handler-case (check-config)
    (error () (uiop:quit -1))))
