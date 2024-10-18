;; Auto-generated. Do not edit!


(when (boundp 'gripper_ntlab_msgs::JointPosition)
  (if (not (find-package "GRIPPER_NTLAB_MSGS"))
    (make-package "GRIPPER_NTLAB_MSGS"))
  (shadow 'JointPosition (find-package "GRIPPER_NTLAB_MSGS")))
(unless (find-package "GRIPPER_NTLAB_MSGS::JOINTPOSITION")
  (make-package "GRIPPER_NTLAB_MSGS::JOINTPOSITION"))

(in-package "ROS")
;;//! \htmlinclude JointPosition.msg.html


(defclass gripper_ntlab_msgs::JointPosition
  :super ros::object
  :slots (_position _mode ))

(defmethod gripper_ntlab_msgs::JointPosition
  (:init
   (&key
    ((:position __position) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:mode __mode) 0)
    )
   (send-super :init)
   (setq _position __position)
   (setq _mode (round __mode))
   self)
  (:position
   (&optional __position)
   (if __position (setq _position __position)) _position)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:serialization-length
   ()
   (+
    ;; float64[] _position
    (* 8    (length _position)) 4
    ;; uint8 _mode
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64[] _position
     (write-long (length _position) s)
     (dotimes (i (length _position))
       (sys::poke (elt _position i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;; uint8 _mode
       (write-byte _mode s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64[] _position
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _position (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _position i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;; uint8 _mode
     (setq _mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get gripper_ntlab_msgs::JointPosition :md5sum-) "42665b9cfa738929ee7f26a4db0bd85b")
(setf (get gripper_ntlab_msgs::JointPosition :datatype-) "gripper_ntlab_msgs/JointPosition")
(setf (get gripper_ntlab_msgs::JointPosition :definition-)
      "float64[] position
uint8 mode

")



(provide :gripper_ntlab_msgs/JointPosition "42665b9cfa738929ee7f26a4db0bd85b")


