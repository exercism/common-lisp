(in-package :stubs)

(defun stub-concept (concept)
  (let ((concept-directory (subdir (relative-directory "concepts") concept)))

    (format-to-file
     (file-in-dir (subdir concept-directory ".meta") "config.json")
     "{\"blurb\": ~S, \"authors\": [~S]}"
     (todo "blurb") *github-username*)

    (format-to-file
     (file-in-dir concept-directory "introduction.md")
     "# Introduction~%~%~A~%" (todo "introduction to ~A" concept))

    (format-to-file
     (file-in-dir concept-directory "about.md")
     "# About~%~%~A~%" (todo "about ~A" concept))

    (format-to-file
     (file-in-dir concept-directory "links.json")
     "[{\"url\": \"https://~A-link.html\", ~
        \"description\": ~S}]" concept (todo "link to ~A" concept))

    (recursive-listing concept-directory)))
