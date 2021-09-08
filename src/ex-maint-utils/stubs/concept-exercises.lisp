(in-package :stubs)

(defun stub-concept-exercise (name)
  (let ((exercise-directory (subdir (relative-directory "exercises" "concept") name)))

    (let ((meta-directory (subdir exercise-directory ".meta")))
      (format-to-file (file-in-dir meta-directory "exemplar.lisp")
                      ";; ~A: exemplar code" "TODO")
      (format-to-file (file-in-dir meta-directory "config.json")
                      "{\"blurb\": \" ~A: ~A blurb\", ~
                        \"authors\": [~S], ~2:*~
                        \"files\": {\"solution\": [\"~A.lisp\"], ~:*~
                                    \"test\": [\"~A-test.lisp\"], ~
                                    \"exemplar\": [\".meta/exemplar.lisp\"]}}"
                      "TODO" name *github-username*))

    (let ((docs-directory (subdir exercise-directory ".docs")))
      (format-to-file (file-in-dir docs-directory "introduction.md")
                      " ~A: introduction" "TODO")
      (format-to-file (file-in-dir docs-directory "instructions.md")
                      " ~A: instructions" "TODO")
      (format-to-file (file-in-dir docs-directory "hints.md")
                      " ~A: hints" "TODO"))

    (format-to-file (file-in-dir exercise-directory (format nil "~A-test.lisp" name))
                    ";; ~A: test file" "TODO")
    (format-to-file (file-in-dir exercise-directory (format nil "~A.lisp" name))
                    ";; ~A: stub file" "TODO")

    (recursive-listing exercise-directory)))
