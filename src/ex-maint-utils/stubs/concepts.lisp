(in-package :stubs)

(defun stub-concept (concept)
  (let ((concept-directory (subdir (relative-directory "concepts") concept)))

    (format-to-file
     (file-in-dir (subdir concept-directory ".meta") "config.json")
     "{\"blurb\": \" ~A: ~A blurb\", \"authors\": [~S]}"
     "TODO" concept *github-username*)

    (format-to-file
     (file-in-dir concept-directory "introduction.md")
     "# Introduction~%~%~A: instruction to ~A~%" "TODO" concept)

    (format-to-file
     (file-in-dir concept-directory "about.md")
     "# About~%~%~A: about ~A~%" "TODO" concept)

    (format-to-file
     (file-in-dir concept-directory "links.json")
     "[{\"url\": \"https://~A-link.html\", ~:*~
        \"description\": \" ~A: link to ~A\"}]" "TODO" concept)

    (recursive-listing concept-directory)))
