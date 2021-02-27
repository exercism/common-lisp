(defun touch (file)
  (open file :direction :probe :if-does-not-exist :create))

(defun stub-exercise (type slug)
  (let ((*default-pathname-defaults*
          (merge-pathnames
           (make-pathname :directory (list :relative "exercises" type slug)))))

    (ensure-directories-exist *default-pathname-defaults* :verbose t)
    (dolist (name (list slug (format nil "~A-test" slug)))
      (touch (make-pathname :name name :type "lisp")))

    (let ((docs-dir (merge-pathnames (pathname ".docs/"))))
      (ensure-directories-exist docs-dir :verbose t)
      (dolist (name (mapcar #'pathname '("introduction.md" "instructions.md" "hints.md")))
        (touch (merge-pathnames name docs-dir))))

    (let ((meta-dir (merge-pathnames (pathname ".meta/"))))
      (ensure-directories-exist meta-dir :verbose t)
      (dolist (name (mapcar #'pathname '("design.md" "example.lisp")))
        (touch (merge-pathnames name meta-dir)))

      (with-open-file (stream (merge-pathnames "config.json" meta-dir)
                              :direction :output :if-exists :supersede)
        (yason:encode (make-hash-table) stream)))))

(defun exercise-slug (ex) (gethash "slug" ex))

(defun exercises-of-type (type)
  (let* ((config (yason:parse (truename "config.json")))
         (exercise-config (gethash "exercises" config))
         (exercises (gethash type exercise-config)))
    (mapcar #'exercise-slug exercises)))

(defun exercise-exists-p (type name)
  (uiop:directory-exists-p
   (make-pathname :directory (list :relative "exercises" type name))))
