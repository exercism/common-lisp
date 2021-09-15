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

(defun missing-exercise-package-error-report (condition stream)
  (format stream
          "Could not find package ~S (perhaps exercise slug and code do not match?)"
          (package-error-package condition)))

(define-condition missing-exercise-package-error (package-error) ()
  (:documentation "Error to signal if exercise package (or exercise test package) cannot be found")
  (:report missing-exercise-package-error-report))

(defun find-exercise-package (exercise &key (test nil))
  (let* ((slug (symbol-name (aget :slug exercise)))
         (package-name (string-upcase (format nil "~A~@[-TEST~]" slug test)))
         (package (find-package package-name)))
    (if (not package)
        (error 'missing-exercise-package-error :package package-name)
        package)))
