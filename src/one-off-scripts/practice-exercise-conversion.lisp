(mapcar #'ql:quickload '("yason" "alexandria"))

(defun keywordize (str)
  (intern (string-upcase str) :keyword))

(defun practice-exercise-directories (&optional (top-level *default-pathname-defaults*))
  (directory (merge-pathnames "./exercises/practice/**" top-level)))

(defun config-file-pathname (dir) (merge-pathnames ".meta/config.json" dir))

(defun load-config (dir)
  (with-open-file (input (config-file-pathname dir) :direction :input)
    (yason:parse input :object-as :alist :object-key-fn #'keywordize)))

(defun write-config (dir config)
  (with-open-file (output (config-file-pathname dir)
                            :direction :output :if-exists :supersede)
    (let ((yason:*list-encoder* #'yason:encode-alist)
          (yason:*symbol-key-encoder* #'yason:encode-symbol-as-lowercase))
      (yason:encode config output))))

(defun slug (dir) (first (last (pathname-directory dir))))

(defun add-to-config (key value config)
  (let ((current-assoc (assoc key config)))
    (if current-assoc
        (progn
          (setf (cdr current-assoc) value)
          config)
        (push (cons key value) config))))

(defun make-file-set (dir)
  (pairlis '(:example :solution :test)
           (list (list "example.lisp")
                 (list (format nil "~A.lisp" (slug dir)))
                 (list (format nil "~A-test.lisp" (slug dir))))))

(defun process-directory (dir)
  (let* ((file-set (make-file-set dir))
         (config (load-config dir))
         (new-config (add-to-config :files file-set
                                    (add-to-config :v2 t config))))
    (write-config dir new-config)))
