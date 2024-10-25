;; Auto-generated. Do not edit!


(when (boundp 'denso_robot_core::PoseData)
  (if (not (find-package "DENSO_ROBOT_CORE"))
    (make-package "DENSO_ROBOT_CORE"))
  (shadow 'PoseData (find-package "DENSO_ROBOT_CORE")))
(unless (find-package "DENSO_ROBOT_CORE::POSEDATA")
  (make-package "DENSO_ROBOT_CORE::POSEDATA"))

(in-package "ROS")
;;//! \htmlinclude PoseData.msg.html


(defclass denso_robot_core::PoseData
  :super ros::object
  :slots (_value _type _pass _exjoints ))

(defmethod denso_robot_core::PoseData
  (:init
   (&key
    ((:value __value) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:type __type) 0)
    ((:pass __pass) 0)
    ((:exjoints __exjoints) (instance denso_robot_core::ExJoints :init))
    )
   (send-super :init)
   (setq _value __value)
   (setq _type (round __type))
   (setq _pass (round __pass))
   (setq _exjoints __exjoints)
   self)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:pass
   (&optional __pass)
   (if __pass (setq _pass __pass)) _pass)
  (:exjoints
   (&rest __exjoints)
   (if (keywordp (car __exjoints))
       (send* _exjoints __exjoints)
     (progn
       (if __exjoints (setq _exjoints (car __exjoints)))
       _exjoints)))
  (:serialization-length
   ()
   (+
    ;; float32[] _value
    (* 4    (length _value)) 4
    ;; int32 _type
    4
    ;; int32 _pass
    4
    ;; denso_robot_core/ExJoints _exjoints
    (send _exjoints :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32[] _value
     (write-long (length _value) s)
     (dotimes (i (length _value))
       (sys::poke (elt _value i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; int32 _type
       (write-long _type s)
     ;; int32 _pass
       (write-long _pass s)
     ;; denso_robot_core/ExJoints _exjoints
       (send _exjoints :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32[] _value
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _value (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _value i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; int32 _type
     (setq _type (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _pass
     (setq _pass (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; denso_robot_core/ExJoints _exjoints
     (send _exjoints :deserialize buf ptr-) (incf ptr- (send _exjoints :serialization-length))
   ;;
   self)
  )

(setf (get denso_robot_core::PoseData :md5sum-) "9b62dc5261dfb262aa32713ca52458d1")
(setf (get denso_robot_core::PoseData :datatype-) "denso_robot_core/PoseData")
(setf (get denso_robot_core::PoseData :definition-)
      "float32[] value
int32     type
int32     pass
ExJoints  exjoints


================================================================================
MSG: denso_robot_core/ExJoints
int32    mode
Joints[] joints


================================================================================
MSG: denso_robot_core/Joints
int32   joint
float64 value


")



(provide :denso_robot_core/PoseData "9b62dc5261dfb262aa32713ca52458d1")


