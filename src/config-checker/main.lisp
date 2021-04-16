(in-package #:config-checker)

(define-condition config-check-failure (error) ())

(defun each-concept-has-a-directory (config)
  (let* ((concepts (track-config:slugs (track-config:listed-concepts config)))
         (bad-concepts
           (remove-if #'(lambda (c) (probe-file (merge-pathnames c "./concepts/"))) concepts)))
    (when bad-concepts
      (dolist (c bad-concepts)
        (format *error-output* "Concept: ~S does not have a directory~&" c))
      (error 'config-check-failure))))

(defun each-concept-directory-is-a-concept (config)
  (let ((concepts (track-config:slugs (track-config:listed-concepts config)))
        (directories (flatten (mapcar #'last
                                      (mapcar #'pathname-directory
                                              (directory "./concepts/*/"))))))
    (let ((orphan-directories (slug-set-diff directories concepts)))
      (when orphan-directories
        (format *error-output* "Concept Directories: ~S are not in concept list~&"
                orphan-directories)
        (error 'config-check-failure)))))

(defun exercise-concepts-are-in-concept-list (config)
  (let* ((concepts (track-config:slugs (track-config:listed-concepts config)))
         (exercises (append (track-config:concept-exercises config)
                            (track-config:practice-exercises config)))
         (exercise-concepts
           (slug-remove-dups
            (append (flat-mapcar #'track-config:practiced-concept-slugs exercises)
                    (flat-mapcar #'track-config:prerequisite-concept-slugs exercises)))))

    (let ((unlisted-concepts (slug-set-diff exercise-concepts concepts)))
      (when unlisted-concepts
        (format *error-output* "Concepts from exercises: ~S not in the concept list~&"
                unlisted-concepts)
        (error 'config-check-failure)))))

(defparameter *checkers* (list #'each-concept-has-a-directory
                               #'each-concept-directory-is-a-concept
                               #'exercise-concepts-are-in-concept-list))

(defun check-config ()
  (let ((config (track-config:read-config "./config.json")))
    (dolist (checker *checkers*)
      (funcall checker config))))

(defun ci-check-config ()
  "Version of CHECK-CONFIG for use in CI processes. Will exit with an error code."
  (handler-case (check-config)
    (error () (uiop:quit -1))))
