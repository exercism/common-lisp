(in-package #:test-exercises)

(defun make-totals (&key (pass 0) (fail 0) (errors 0))
  (list :pass pass :fail fail :errors errors))

(defun add-totals (totals delta)
  (incf (getf totals :pass) (getf delta :pass))
  (incf (getf totals :fail) (getf delta :fail))
  (incf (getf totals :errors) (getf delta :errors))
  totals)

(defun failure (obj) (format t "~&;;; >>>FAILURE: ~A" obj))

(defgeneric report-test-result (result))

(defmethod report-test-result ((result lisp-unit::test-results-db))
  (map nil #'failure (append (lisp-unit:failed-tests result)
                             (lisp-unit:error-tests result)))

  (make-totals :pass (lisp-unit::pass result)
               :fail (lisp-unit::fail result)
               :errors (lisp-unit::exerr result)))

(defmethod report-test-result ((result fiveam::test-failure))
  (failure (fiveam::name (fiveam::test-case result)))
  (make-totals :fail 1))

(defmethod report-test-result ((result fiveam::test-passed))
  (make-totals :pass 1))

(defmethod report-test-result ((result error))
  (failure result)
  (make-totals :errors 1))

(defun report-result (result)
  (let ((exercise (aget :exercise result))
        (results (aget :results result)))

    (let ((totals (reduce #'(lambda (totals result)
                              (add-totals totals (report-test-result result)))
                          results
                          :initial-value (make-totals))))

      (format t "~&;; ~A ~A ~A"
              (aget :type exercise)
              (aget :slug exercise)
              totals)

      totals)))

(defun report-results (results)
  (format t "~&;;;;~&;;;; TEST RESULTS~&;;;;~&;;")

  (let ((totals
          (reduce
           #'(lambda (totals result) (add-totals totals (report-result result)))
           results
           :initial-value (make-totals))))

    (format t "~&;;;;~&;;;; TOTAL TESTS: ~S ~&;;;;" totals)

    totals))
