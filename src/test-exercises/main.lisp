(in-package #:test-exercises)

(defun run-all-tests ()
  (let ((all-exercise-directories (append (list-exercise-directories "concept")
                                          (list-exercise-directories "practice")))
        (results (list)))
    (report-results
     (reduce #'(lambda (acc ex) (push (test-exercise ex) acc))
             all-exercise-directories
             :initial-value results))))
