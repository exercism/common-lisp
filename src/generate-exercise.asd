(defsystem generate-exercise
  :name "generate-exercise"
  :version "0.0.1"
  :description "Generate Exercises"
  :long-description "Utility to generate exercism exercises from canonical test data"

  :depends-on ("cl-json")

  :serial t
  :components ((:file "exercise-data")
               (:file "generate-tests")))
