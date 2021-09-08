(in-package :stubs)

(defun stub-concept-exercise (name)
  (let ((exercise-directory (subdir (relative-directory "exercises" "concept") name)))

    (let ((meta-directory (subdir exercise-directory ".meta")))
      (format-to-file (file-in-dir meta-directory "exemplar.lisp")
                      (lisp-todo "exemplar code"))
      (format-to-file (file-in-dir meta-directory "config.json")
                      "{\"blurb\": ~S,~
                        \"authors\": [~S],~
                        \"files\": {\"solution\": [\"~A.lisp\"], ~:*~
                                    \"test\": [\"~A-test.lisp\"], ~
                                    \"exemplar\": [\".meta/exemplar.lisp\"]}}"
                      (todo name)
                      *github-username* name))

    (let ((docs-directory (subdir exercise-directory ".docs")))
      (format-to-file (file-in-dir docs-directory "introduction.md")
                      (todo "introduction"))
      (format-to-file (file-in-dir docs-directory "instructions.md")
                      (todo "instructions"))
      (format-to-file (file-in-dir docs-directory "hints.md")
                      (todo "hints")))

    (format-to-file (file-in-dir exercise-directory (format nil "~A-test.lisp" name))
                    (lisp-todo "test file"))
    (format-to-file (file-in-dir exercise-directory (format nil "~A.lisp" name))
                    (lisp-todo "stub file"))

    (recursive-listing exercise-directory)))
