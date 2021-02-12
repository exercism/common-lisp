(in-package #:test-exercises)

;; for v2 test running
(pushnew :xlisp-test *features*)

(defun example-files (data)
  (or (aget :exemplar (aget :files data))
      (aget :example (aget :files data))))

(defun test-v2-exercise (data)
  (let ((test-files (aget :test (aget :files data)))
        (solution-files (aget :solution (aget :files data)))
        (exemplar-files (example-files data)))
    (unwind-protect
         (progn
           (dolist (f (append solution-files exemplar-files test-files))
             (load-exercise-file data f))
           (list
            (let ((lisp-unit:*summarize-results* nil))
              (lisp-unit:run-tests :all (find-exercise-package data :test t)))))
      (delete-package (find-exercise-package data :test t))
      (delete-package (find-exercise-package data)))))

(defun test-v3-exercise (data)
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
                       (if (aget :v2 data)
                           (test-v2-exercise data)
                           (test-v3-exercise data))
                     (error (c) (list c)))))))
