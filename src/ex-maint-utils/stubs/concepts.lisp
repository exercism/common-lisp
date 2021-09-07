(in-package :stubs)

(defun stub-concept (concept)
  (let ((concept-directory (subdir (relative-directory "concepts") concept)))

    (write-string-to-file
     (format-template
      "{\"blurb\": \"TODO: ~A blurb\", \"authors\": [~/stubs:github-username/]}"
      concept)
     (file-in-dir (subdir concept-directory ".meta") "config.json"))

    (write-string-to-file
     (format-template "# Introduction~%~%TODO: instruction to ~A~%" concept)
     (file-in-dir concept-directory "introduction.md"))

    (write-string-to-file
     (format-template "# About~%~%TODO: about ~A~%" concept)
     (file-in-dir concept-directory "about.md"))

    (write-string-to-file
     (format-template "[{\"url\": \"https://~A-link.html\", ~:*~
                  \"description\": \"TODO: link to ~A\"}]" concept)
     (file-in-dir concept-directory "links.json"))

    (recursive-listing concept-directory)))
