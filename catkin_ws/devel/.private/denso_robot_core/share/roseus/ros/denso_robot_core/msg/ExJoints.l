;; Auto-generated. Do not edit!


(when (boundp 'denso_robot_core::ExJoints)
  (if (not (find-package "DENSO_ROBOT_CORE"))
    (make-package "DENSO_ROBOT_CORE"))
  (shadow 'ExJoints (find-package "DENSO_ROBOT_CORE")))
(unless (find-package "DENSO_ROBOT_CORE::EXJOINTS")
  (make-package "DENSO_ROBOT_CORE::EXJOINTS"))

(in-package "ROS")
;;//! \htmlinclude ExJoints.msg.html


(defclass denso_robot_core::ExJoints
  :super ros::object
  :slots (_mode _joints ))

(defmethod denso_robot_core::ExJoints
  (:init
   (&key
    ((:mode __mode) 0)
    ((:joints __joints) ())
    )
   (send-super :init)
   (setq _mode (round __mode))
   (setq _joints __joints)
   self)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:joints
   (&rest __joints)
   (if (keywordp (car __joints))
       (send* _joints __joints)
     (progn
       (if __joints (setq _joints (car __joints)))
       _joints)))
  (:serialization-length
   ()
   (+
    ;; int32 _mode
    4
    ;; denso_robot_core/Joints[] _joints
    (apply #'+ (send-all _joints :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _mode
       (write-long _mode s)
     ;; denso_robot_core/Joints[] _joints
     (write-long (length _joints) s)
     (dolist (elem _joints)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _mode
     (setq _mode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; denso_robot_core/Joints[] _joints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _joints (let (r) (dotimes (i n) (push (instance denso_robot_core::Joints :init) r)) r))
     (dolist (elem- _joints)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get denso_robot_core::ExJoints :md5sum-) "cf76e185e2fbb6a8349fec25c2682163")
(setf (get denso_robot_core::ExJoints :datatype-) "denso_robot_core/ExJoints")
(setf (get denso_robot_core::ExJoints :definition-)
      "int32    mode
Joints[] joints


================================================================================
MSG: denso_robot_core/Joints
int32   joint
float64 value


")



(provide :denso_robot_core/ExJoints "cf76e185e2fbb6a8349fec25c2682163")


