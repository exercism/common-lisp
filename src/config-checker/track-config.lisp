(in-package #:track-config)

(defun read-config (&optional (config-file "./config.json"))
  (yason:parse (truename config-file)))

(defun slugs (items)
  (mapcar #'(lambda (c) (gethash "slug" c)) items))

(defun listed-concepts (config)
  (gethash "concepts" config))

(defun concept-exercises (config)
  (gethash "concept" (gethash "exercises" config)))

(defun practice-exercises (config)
  (gethash "practice" (gethash "exercises" config)))

(defun prerequisite-concept-slugs (exercise)
  (gethash "prerequisites" exercise))

(defun practiced-concept-slugs (exercise)
  (or (gethash "concepts" exercise)
      (gethash "practices" exercise)))
