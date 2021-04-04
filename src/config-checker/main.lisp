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

(defun exercise-concepts-are-in-concept-list (config)
  (let* ((exercises (gethash "exercises" config))
         (concepts (sort (copy-seq (mapcar #'(lambda (h) (gethash "slug" h))
                                           (gethash "concepts" config)))
                         #'string<))
         (concept-exercises  (gethash "concept" exercises))
         (practice-exercises (gethash "practice" exercises))

         (exercise-concepts
           (delete-duplicates
            (sort
             (append (apply #'append (mapcar #'(lambda (h) (gethash "concepts" h)) concept-exercises))
                     (apply #'append (mapcar #'(lambda (h) (gethash "practices" h)) practice-exercises))
                     (apply #'append (mapcar #'(lambda (h) (gethash "prerequisites" h)) practice-exercises)))
             #'string<)
            :test #'string=)))

    (let ((unlisted-concepts (set-difference exercise-concepts concepts :test #'string=)))
      (when unlisted-concepts
        (format *error-output* "Concepts from exercises: ~S not in the concept list~&"
                unlisted-concepts)
        (error 'config-check-failure)))))

(defparameter *checkers* (list #'each-concept-has-a-directory
                               #'exercise-concepts-are-in-concept-list))

(defun check-config ()
  (let ((config (yason:parse (truename "./config.json"))))
    (dolist (checker *checkers*)
      (funcall checker config))))

(defun ci-check-config ()
  "Version of CHECK-CONFIG for use in CI processes. Will exit with an error code."
  (handler-case (check-config)
    (error () (uiop:quit -1))))
