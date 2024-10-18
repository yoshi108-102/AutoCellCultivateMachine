;; Auto-generated. Do not edit!


(when (boundp 'denso_robot_core::Joints)
  (if (not (find-package "DENSO_ROBOT_CORE"))
    (make-package "DENSO_ROBOT_CORE"))
  (shadow 'Joints (find-package "DENSO_ROBOT_CORE")))
(unless (find-package "DENSO_ROBOT_CORE::JOINTS")
  (make-package "DENSO_ROBOT_CORE::JOINTS"))

(in-package "ROS")
;;//! \htmlinclude Joints.msg.html


(defclass denso_robot_core::Joints
  :super ros::object
  :slots (_joint _value ))

(defmethod denso_robot_core::Joints
  (:init
   (&key
    ((:joint __joint) 0)
    ((:value __value) 0.0)
    )
   (send-super :init)
   (setq _joint (round __joint))
   (setq _value (float __value))
   self)
  (:joint
   (&optional __joint)
   (if __joint (setq _joint __joint)) _joint)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; int32 _joint
    4
    ;; float64 _value
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _joint
       (write-long _joint s)
     ;; float64 _value
       (sys::poke _value (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _joint
     (setq _joint (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _value
     (setq _value (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get denso_robot_core::Joints :md5sum-) "f3296c44b7dd5760cc0f63c8b23c701f")
(setf (get denso_robot_core::Joints :datatype-) "denso_robot_core/Joints")
(setf (get denso_robot_core::Joints :definition-)
      "int32   joint
float64 value


")



(provide :denso_robot_core/Joints "f3296c44b7dd5760cc0f63c8b23c701f")


