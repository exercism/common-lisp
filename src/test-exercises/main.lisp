(in-package #:test-exercises)

;; for v2 test running
(pushnew :xlisp-test *features*)

(defparameter +source-directory-pathname+
  (make-pathname :directory (pathname-directory
                             #.(or *compile-file-pathname* *load-pathname*)))
  "Location of this source of the TEST-EXERCISES system source code. 
Location of other files in the common-lisp track will be found relative to this.")

(defun aget (key alist) (cdr (assoc key alist)))

(defun find-exercise-directory ()
  (merge-pathnames
   (make-pathname :directory (list :relative :up :up "exercises"))
   +source-directory-pathname+))

(defun list-exercise-directories (type)
  (directory (merge-pathnames
              (make-pathname :directory (list :relative type :wild))
              (find-exercise-directory))))

(defun keywordize (str)
  (intern (string-upcase str) :keyword))

(defun slurp-exercise-config (dir)
  (let ((config-file (merge-pathnames ".meta/config.json" dir)))
    (if (probe-file config-file)
        (cl-json:decode-json-from-source config-file)
        ;; this is a v2 exercise not yet converted let's try to do something useful
        (let ((slug (first (last (pathname-directory dir)))))
          (pairlis '(:files :v2)
                   (list (pairlis '(:test :solution :exemplar)
                                  (list (list (format nil "~A-test.lisp" slug))
                                        (list (format nil "~A.lisp" slug))
                                        (list "example.lisp")))
                         t))))))

(defun gather-exercise-data (dir)
  (destructuring-bind (type slug)
      (mapcar #'keywordize (last (pathname-directory dir) 2))
    (let ((config (slurp-exercise-config dir)))
      (pairlis '(:directory :type :slug :files :v2)
               (list dir type slug (aget :files config) (aget :v2 config))))))

(defun exercise-file-pathname (exercise file)
  (let ((directory (aget :directory exercise)))
    (merge-pathnames file directory)))

(defun load-exercise-file (exercise file)
  (let ((*default-pathname-defaults* (aget :directory exercise))
        (*load-verbose* t))
    (load file)))

(defun find-exercise-package (exercise &key (test nil))
  (let ((slug (symbol-name (aget :slug exercise))))
   (find-package (string-upcase (format nil "~A~@[-TEST~]" slug test)))))

(defun test-v2-exercise (data)
  (let ((test-files (aget :test (aget :files data)))
        (solution-files (aget :solution (aget :files data)))
        (exemplar-files (aget :exemplar (aget :files data))))
    (unwind-protect
         (progn
           (dolist (f (append solution-files exemplar-files test-files))
             (load-exercise-file data f))
           (lisp-unit:run-tests :all (find-exercise-package data :test t)))
      (delete-package (find-exercise-package data))
      (delete-package (find-exercise-package data :test t)))))

(defun test-v3-exercise (data)
  (let ((test-files (aget :test (aget :files data)))
        (exemplar-files (aget :exemplar (aget :files data))))

    (unwind-protect
         (progn
           (dolist (f (append test-files exemplar-files))
             (load-exercise-file data f))
           (fiveam:run (find-symbol
                        (format nil "~A-SUITE" (symbol-name (aget :slug data)))
                        (find-exercise-package data :test t)))))))

(defun test-exercise (dir)
  (sb-ext:gc :full t)
  (let ((data (gather-exercise-data dir)))
    (if (aget :v2 data)
        (test-v2-exercise data)
        (test-v3-exercise data))))


(defun run-all-tests ()
  (let ((all-exercise-directories (append (list-exercise-directories "concept")
                                          (list-exercise-directories "practice")))
        (results (list)))
    (reduce #'(lambda (acc ex) (push (test-exercise ex) acc))
            all-exercise-directories
            :initial-value results)))
