(in-package :test-exercises)

(defun slurp-exercise-config (dir)
  (let ((config-file (merge-pathnames ".meta/config.json" dir)))
    (with-open-file (input config-file :direction :input :if-does-not-exist :error)
      (yason:parse input :object-key-fn #'keywordize :object-as :alist))))

(defun gather-exercise-data (dir)
  (destructuring-bind (type slug)
      (mapcar #'keywordize (last (pathname-directory dir) 2))
    (let ((config (slurp-exercise-config dir)))
      (pairlis '(:directory :type :slug :files)
               (list dir type slug (aget :files config))))))

(defun load-exercise-file (exercise file)
  (let ((*default-pathname-defaults* (aget :directory exercise))
        (*load-verbose* t))
    (handler-bind ((style-warning #'muffle-warning))
      (load file))))

(defun find-exercise-package (exercise &key (test nil))
  (let ((slug (symbol-name (aget :slug exercise))))
   (find-package (string-upcase (format nil "~A~@[-TEST~]" slug test)))))
