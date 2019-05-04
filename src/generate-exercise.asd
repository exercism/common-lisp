(defsystem "generate-exercise"
  :name "generate-exercise"
  :version "0.0.1"
  :description "Generate Exercises"
  :long-description "Utility to generate exercism exercises from canonical test data"

  :depends-on ("cl-json" "uiop")

  :serial t
  :components ((:module "generate-exercise"
                        :components ((:file "exercise-data")
                                     (:file "config-data" :depends-on ("configlet"))
                                     (:file "configlet")
                                     (:file "generate-exercise"
                                            :depends-on ("exercise-data"
                                                         "configlet"
                                                         "config-data"))))))

(defsystem "generate-exercise/executable"
  :name "generate-execercise/executeable"
  :depends-on ("generate-exercise" "unix-opts")
  :build-operation program-op
  :build-pathname "../../bin/generate-exercise"
  :entry-point "generate-exercise-main:main"
  :pathname "generate-exercise"
  :components ((:file "generate-exercise-main")))

