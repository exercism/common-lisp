(in-package #:config-checker)

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

(push #'each-concept-directory-is-a-concept *checkers*)
