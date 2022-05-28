(defpackage :two-bucket
  (:use :cl)
  (:export :measure))

(in-package :two-bucket)

(shadow 'fill)

(defclass bucket ()
  ((capacity :initarg :capacity
             :reader capacity)
   (amount :initform 0
           :reader amount)
   (name :initarg :name
         :reader name)))

(defgeneric empty (obj)
  (:documentation "Empty the bucket."))

(defgeneric fill (obj)
  (:documentation "Fill the bucket."))

(defgeneric fullp (obj)
  (:documentation "Return T if the bucket is full (i.e. amount == capacity)."))

(defgeneric overflowingp (obj)
  (:documentation "Determine if the bucket is overflowing and if so, return the
 excess (i.e. excess = amount - capacity)."))

(defgeneric transfer (from-bucket to-bucket)
  (:documentation "Pour water from the from-bucket into the to-bucket."))

(defmethod empty ((obj bucket))
  (setf (slot-value obj 'amount) 0))

(defmethod fill ((obj bucket))
  (setf (slot-value obj 'amount) (slot-value obj 'capacity)))

(defmethod fullp ((obj bucket))
  (= (slot-value obj 'amount) (slot-value obj 'capacity)))

(defmethod overflowingp ((obj bucket))
  (when (> (slot-value obj 'amount) (slot-value obj 'capacity))
    (- (slot-value obj 'amount) (slot-value obj 'capacity))))

(defmethod transfer ((from-bucket bucket) (to-bucket bucket))
  (incf (slot-value to-bucket 'amount) (slot-value from-bucket 'amount))
  (empty from-bucket)
  (let ((excess (overflowingp to-bucket)))
    (when excess
      (setf (slot-value from-bucket 'amount) excess)
      (fill to-bucket))))

(defun unsolvablep (bucket-one bucket-two goal)
  "Given two buckets and a goal, function will return T if the puzzle cannot be solved."
  (or (plusp (mod goal (gcd bucket-one bucket-two)))
      (and (> goal bucket-one) (> goal bucket-two))))

(defun retrieve-results (bucket-one bucket-two goal)
  "Given two buckets and a goal, function will return a list comprising the name of
the bucket that reached that goal, and the amount left in the other bucket."
  (if (= goal (amount bucket-one))
    (list (name bucket-one) (amount bucket-two))
    (list (name bucket-two) (amount bucket-one))))

(defun iterate-through-puzzle (start-bucket other-bucket goal)
  "Function to solve the two-bucket puzzle using iteration.  Returns a list comprising
the number of moves needed to reach a solution, the name of the solution bucket,
and the amount left in the non-solution bucket."
  (fill start-bucket)
  (loop for moves from 1
        until (or (= goal (amount start-bucket)) (= goal (amount other-bucket)))
    do (cond
         ((= goal (capacity other-bucket)) (fill other-bucket)) ; Only matters on first iteration
         ((fullp other-bucket) (empty other-bucket))
         ((zerop (amount start-bucket)) (fill start-bucket))
         (t (transfer start-bucket other-bucket)))
    finally (return (cons moves (retrieve-results start-bucket other-bucket goal)))))

(defun measure (bucket-one bucket-two goal start-bucket)
  "Function to solve the two-bucket puzzle, if possible, when given the capacities
of both buckets, a goal, and which bucket to start with.  Returns an alist of moves
required to reach the goal, the name of the bucket that reach the goal, and the
amount of water left over in the other bucket."
  (unless (unsolvablep bucket-one bucket-two goal)
    (let* ((first-bucket (make-instance 'bucket :capacity bucket-one :name :one))
           (second-bucket (make-instance 'bucket :capacity bucket-two :name :two))
           (results (if (eql start-bucket :one)
                      (iterate-through-puzzle first-bucket second-bucket goal)
                      (iterate-through-puzzle second-bucket first-bucket goal))))
      (pairlis '(:moves :goal-bucket :other-bucket) results))))
