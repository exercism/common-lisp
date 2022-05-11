(defpackage :two-bucket
  (:use :cl)
  (:export :measure))

(in-package :two-bucket)

(defun measure (bucket-one bucket-two goal start-bucket)
  (unless (invalid-input-p bucket-one bucket-two goal)
    (let* ((first-bucket (make-instance 'bucket :capacity bucket-one :name "one"))
           (second-bucket (make-instance 'bucket :capacity bucket-two :name "two"))
           (results (if (string= start-bucket "one")
                      (iterate-through-puzzle first-bucket second-bucket goal)
                      (iterate-through-puzzle second-bucket first-bucket goal))))
      (pairlis '("moves" "goal-bucket" "other-bucket") results))))

(defun invalid-input-p (bucket-one bucket-two goal)
  (or (plusp (mod goal (gcd bucket-one bucket-two)))
      (and (> goal bucket-one) (> goal bucket-two))))

(defun iterate-through-puzzle (start-bucket other-bucket goal)
  (fill-bucket start-bucket)
  (loop for moves from 1
        until (= goal (amount start-bucket))
        until (= goal (amount other-bucket))
    do (cond
         ((= goal (capacity other-bucket)) (fill-bucket other-bucket))
         ((fullp other-bucket) (empty other-bucket))
         ((zerop (amount start-bucket)) (fill-bucket start-bucket))
         (t (transfer start-bucket other-bucket)))
    finally (return (cons moves (retrieve-results start-bucket other-bucket goal)))))

(defun retrieve-results (bucket-one bucket-two goal)
  (if (= goal (amount bucket-one))
    (list (name bucket-one) (amount bucket-two))
    (list (name bucket-two) (amount bucket-one))))

(defclass bucket ()
  ((capacity :initarg :capacity
             :reader capacity)
   (amount :initform 0
           :reader amount)
   (name :initarg :name
         :reader name)))

(defmethod empty ((obj bucket))
  (setf (slot-value obj 'amount) 0))

(defmethod fill-bucket ((obj bucket))
  (setf (slot-value obj 'amount) (slot-value obj 'capacity)))

(defmethod fullp ((obj bucket))
  (= (slot-value obj 'amount) (slot-value obj 'capacity)))

(defmethod overflowingp ((obj bucket))
  (when (> (slot-value obj 'amount) (slot-value obj 'capacity))
    (- (slot-value obj 'amount) (slot-value obj 'capacity))))

(defmethod combined-amounts ((bucket-one bucket) (bucket-two bucket))
  (+ (slot-value bucket-two 'amount) (slot-value bucket-one 'amount)))

(defmethod transfer ((from-bucket bucket) (to-bucket bucket))
  (setf (slot-value to-bucket 'amount) (combined-amounts from-bucket to-bucket))
  (empty from-bucket)
  (when (setf excess (overflowingp to-bucket))
    (setf (slot-value from-bucket 'amount) excess)
    (fill-bucket to-bucket)))
