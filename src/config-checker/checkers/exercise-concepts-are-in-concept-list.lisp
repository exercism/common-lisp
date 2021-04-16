(in-package #:config-checker)

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

(push #'exercise-concepts-are-in-concept-list *checkers*)
