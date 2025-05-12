(defpackage :relative-distance
  (:use :cl)
  (:export :degree-of-separation))

(in-package :relative-distance)

(defun degree-of-separation (family-tree person-a person-b)
  (let ((neighbors (make-hash-table :test 'equal)))

    (dolist (entry family-tree)
            (let ((parent (car entry))
                  (children (cdr entry)))

              (unless (gethash parent neighbors)
                (setf (gethash parent neighbors) (make-hash-table :test 'equal)))

              (dolist (child children)
                      (unless (gethash child neighbors)
                        (setf (gethash child neighbors) (make-hash-table :test 'equal)))
                      (setf (gethash child (gethash parent neighbors)) t)
                      (setf (gethash parent (gethash child neighbors)) t))

              (dolist (child-a children)
                      (dolist (child-b children)
                              (unless (equal child-a child-b)
                                (setf (gethash child-a (gethash child-b neighbors)) t)
                                (setf (gethash child-b (gethash child-a neighbors)) t))))))

    (unless (and (gethash person-a neighbors) (gethash person-b neighbors))
      (return-from degree-of-separation nil))


    (let ((queue (list (cons person-a 0)))
          (visited (make-hash-table :test 'equal)))

      (setf (gethash person-a visited) t)

      (loop while queue do
            (let* ((current (pop queue))
                   (current-person (car current))
                   (current-degree (cdr current)))

              (when (equal current-person person-b)
                (return-from degree-of-separation current-degree))

              (let ((current-neighbors (gethash current-person neighbors)))
                (when current-neighbors
                  (maphash (lambda (neighbor _)
                             (unless (gethash neighbor visited)
                               (setf (gethash neighbor visited) t)
                               (setf queue (append queue (list (cons neighbor (1+ current-degree)))))))
                           current-neighbors))))))

    nil))
