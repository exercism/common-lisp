(defpackage :config-checker
  (:use :cl)
  (:export :check-config
           :ci-check-config))

(defpackage :track-config
  (:use :cl)
  (:export :read-config
           :slugs
           :listed-concepts
           :concept-exercises
           :practice-exercises
           :prerequisite-concept-slugs
           :practiced-concept-slugs))
