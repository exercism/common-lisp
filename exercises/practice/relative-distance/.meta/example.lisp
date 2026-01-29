(defpackage :relative-distance
  (:use :cl)
  (:export :degree-of-separation))

(in-package :relative-distance)

(defun build-graph (family-tree)
  (let ((neighbors (make-hash-table :test 'equal)))
    (loop for (parent . children) in family-tree do
          (unless (gethash parent neighbors)
            (setf (gethash parent neighbors)
                  (make-hash-table :test 'equal)))
          (loop for child in children do
            (unless (gethash child neighbors)
              (setf (gethash child neighbors)
                    (make-hash-table :test 'equal)))
            (setf (gethash child (gethash parent neighbors)) t
                  (gethash parent (gethash child neighbors)) t))
          (loop for (child-a . rest) on children do
                (loop for child-b in rest do
                  (setf (gethash child-a (gethash child-b neighbors)) t
                        (gethash child-b (gethash child-a neighbors)) t))))
    neighbors))

(defun degree-of-separation (family-tree person-a person-b)
  (let ((neighbors (build-graph family-tree)))
    (when (and (gethash person-a neighbors)
               (gethash person-b neighbors))
      (let ((queue (list (cons person-a 0)))
            (visited (make-hash-table :test 'equal)))
        (setf (gethash person-a visited) t)
        (loop while queue
              for (current-person . current-degree) = (pop queue)
              if (equal current-person person-b)
                return current-degree
              do (maphash (lambda (neighbor val)
                            (declare (ignore val))
                            (unless (gethash neighbor visited)
                              (setf (gethash neighbor visited) t
                                    queue (append queue (list (cons neighbor (1+ current-degree)))))))
                          (gethash current-person neighbors)))))))
