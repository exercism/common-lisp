(defsystem "ex-maint-utils"
  :description "Exercism utilities for track maintenance"
  :version "0.0.1"
  :author "Mark Simpson"
  :mailto "verdammelt@gmail.com"

  :depends-on ("alexandria")

  :pathname "ex-maint-utils"
  :serial t
  :components ((:module "stubs"
                :components ((:file "package")
                             (:file "utils")
                             (:file "concepts")
                             (:file "concept-exercises")))
               (:file "package")))
