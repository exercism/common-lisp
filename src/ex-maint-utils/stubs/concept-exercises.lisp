(in-package :stubs)

(defun stub-concept-exercise (name)
  (let ((exercise-directory (subdir (relative-directory "exercises" "concept") name)))

    (let ((meta-directory (subdir exercise-directory ".meta")))
      (write-string-to-file ";; TODO: exemplar code"
       (file-in-dir meta-directory "exemplar.lisp"))
      (write-string-to-file
       (format nil "{\"blurb\": \"TODO: ~A blurb\", ~:*~
                   \"authors\": [~/stubs:github-username/], ~:*~
                   \"files\": {\"solution\": [\"~A.lisp\"], ~:*~
                               \"test\": [\"~A-test.lisp\"], ~
                               \"exemplar\": [\".meta/exemplar.lisp\"]}}"
               name)
       (file-in-dir meta-directory "config.json")))

    (let ((docs-directory (subdir exercise-directory ".docs")))
      (write-string-to-file "TODO: introduction"
                       (file-in-dir docs-directory "introduction.md"))
      (write-string-to-file "TODO: instructions"
                       (file-in-dir docs-directory "instructions.md"))
      (write-string-to-file "TODO: hints"
                       (file-in-dir docs-directory "hints.md")))

    (write-string-to-file ";; TODO: test file"
     (file-in-dir exercise-directory (format nil "~A-test.lisp" name)))
    (write-string-to-file ";; TODO: stub file"
     (file-in-dir exercise-directory (format nil "~A.lisp" name)))

    (recursive-listing exercise-directory)))
