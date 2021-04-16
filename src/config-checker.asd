(defsystem "config-checker"
  :description ""
  :version "0.0.0"
  :author "Mark Simpson"
  :mailto "verdammelt@gmail.com"

  :depends-on ("yason")

  :pathname "config-checker"
  :serial t
  :components ((:file "packages")
               (:file "track-config")
               (:file "utils")
               (:file "main")
               (:module "checkers"
                :components ((:file "each-concept-directory-is-a-concept")
                             (:file "each-concept-has-a-directory")
                             (:file "exercise-concepts-are-in-concept-list")))))
