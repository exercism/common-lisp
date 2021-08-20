(in-package :test-exercises)

(defun run-all-tests ()
  (let ((all-exercise-directories (append (list-exercise-directories "concept")
                                          (list-exercise-directories "practice"))))
    (let ((result-totals
            (report-results
             (nreverse
              (reduce #'(lambda (acc ex) (push (test-exercise ex) acc))
                      all-exercise-directories
                      :initial-value (list))))))
      (when (or (plusp (getf result-totals :fail))
                (plusp (getf result-totals :errors)))
        (error "Test Failures Detected.")))))
