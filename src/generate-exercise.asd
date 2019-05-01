(defsystem "generate-exercise"
  :name "generate-exercise"
  :version "0.0.1"
  :description "Generate Exercises"
  :long-description "Utility to generate exercism exercises from canonical test data"

  :depends-on ("cl-json" "uiop")

  :serial t
  :components ((:file "exercise-data")
               (:file "generate-exercise")))

(defsystem "generate-exercise/executable"
  :name "generate-execercise/executeable"
  :depends-on ("generate-exercise" "unix-opts")
  :build-operation program-op
  :build-pathname "../bin/generate-exercise"
  :entry-point "generate-exercise-main:main"
  :components ((:file "generate-exercise-main")))
