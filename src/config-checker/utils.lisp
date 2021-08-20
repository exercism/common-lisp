(in-package :config-checker)

(defun flatten (list-of-lists) (apply #'append list-of-lists))
(defun flat-mapcar (fn &rest lists) (flatten (apply #'mapcar fn lists)))

(defun slug-set-diff (slugs1 slugs2)
  (set-difference slugs1 slugs2 :test #'string=))
(defun slug-remove-dups (slugs)
  (remove-duplicates slugs :test #'string=))
