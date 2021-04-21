(in-package #:test-exercises)

(defun example-files (data)
  (or (aget :exemplar (aget :files data))
      (aget :example (aget :files data))))

(defun %test-exercise (data)
  (let ((test-files (aget :test (aget :files data)))
        (exemplar-files (example-files data)))
    (unwind-protect
         (progn
           (dolist (f (append test-files exemplar-files))
             (load-exercise-file data f))
           (let ((fiveam:*print-names* nil))
             (fiveam:run (find-symbol
                          (format nil "~A-SUITE" (symbol-name (aget :slug data)))
                          (find-exercise-package data :test t)))))
      (delete-package (find-exercise-package data :test t))
      (delete-package (find-exercise-package data)))))

(defun test-exercise (dir)
  (sb-ext:gc :full t)
  (let ((data (gather-exercise-data dir)))
    (pairlis '(:exercise :results)
             (list data
                   (handler-case
                       (%test-exercise data)
                     (error (c) (list c)))))))
