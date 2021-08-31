;; Ensures that high-scores.lisp and the testing library are always loaded
(eval-when (:compile-toplevel :load-toplevel :execute)
  (load "high-scores")
  (ql:quickload :fiveam))

;; Defines the testing package with symbols from high-scores and FiveAM in scope
;; The `run-tests` function is exported for use by both the user and test-runner
(defpackage :high-scores-test
  (:use :cl :fiveam :high-scores)
  (:export :run-tests))

;; Enter the testing package
(in-package :high-scores-test)

;; Define and enter a new FiveAM test-suite
(def-suite high-scores-suite)
(in-suite high-scores-suite)

(test creating-the-table
  (let ((table (make-high-scores-table)))
    (is (hash-table-p table))
    (is (zerop (hash-table-count table)))))

(test adding-player-to-table
  (let ((table (make-high-scores-table)))
    (add-player table :lewis)

    (is-true (second (multiple-value-list (gethash :lewis table))))))

(test set-player-score
  (let ((table (make-high-scores-table)))
    (add-player table :lewis)
    (set-score table :lewis 1234)

    (is (= 1234 (gethash :lewis table 'no-score)))))

(test default-score
  (let ((table (make-high-scores-table)))
    (add-player table :lewis)

    (is (= 0 (get-score table :lewis)))))

(test default-score-for-player-not-in-table
  (let ((table (make-high-scores-table)))
    (is (= 0 (get-score table :lewis)))))

(test removing-a-player
  (let ((table (make-high-scores-table)))
    (add-player table :lewis)
    (remove-player table :lewis)

    (is-false (second (multiple-value-list (gethash :lewis table))))))

(test removed-player-has-default-score
  (let ((table (make-high-scores-table)))
    (add-player table :lewis)
    (set-score table :lewis 1234)
    (remove-player table :lewis)

    (is (= 0 (get-score table :lewis)))))


(test removing-a-player
  (let ((table (make-high-scores-table)))
    (remove-player table :lewis)
    (is-false (second (multiple-value-list (gethash :lewis table))))))

(defun run-tests (&optional (test-or-suite 'high-scores-suite))
  "Provides human readable results of test run. Default to entire suite."
  (run! test-or-suite))
