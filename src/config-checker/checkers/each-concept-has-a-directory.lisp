(in-package :config-checker)

(defun each-concept-has-a-directory (config)
  (let* ((concepts (track-config:slugs (track-config:listed-concepts config)))
         (bad-concepts
           (remove-if #'(lambda (c) (probe-file (merge-pathnames c "./concepts/"))) concepts)))
    (when bad-concepts
      (dolist (c bad-concepts)
        (format *error-output* "Concept: ~S does not have a directory~&" c))
      (error 'config-check-failure))))

(push #'each-concept-has-a-directory *checkers*)
