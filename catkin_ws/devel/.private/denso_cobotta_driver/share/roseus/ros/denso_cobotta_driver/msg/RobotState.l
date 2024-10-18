;; Auto-generated. Do not edit!


(when (boundp 'denso_cobotta_driver::RobotState)
  (if (not (find-package "DENSO_COBOTTA_DRIVER"))
    (make-package "DENSO_COBOTTA_DRIVER"))
  (shadow 'RobotState (find-package "DENSO_COBOTTA_DRIVER")))
(unless (find-package "DENSO_COBOTTA_DRIVER::ROBOTSTATE")
  (make-package "DENSO_COBOTTA_DRIVER::ROBOTSTATE"))

(in-package "ROS")
;;//! \htmlinclude RobotState.msg.html


(defclass denso_cobotta_driver::RobotState
  :super ros::object
  :slots (_arm_no _state_code _state_subcode ))

(defmethod denso_cobotta_driver::RobotState
  (:init
   (&key
    ((:arm_no __arm_no) 0)
    ((:state_code __state_code) 0)
    ((:state_subcode __state_subcode) 0)
    )
   (send-super :init)
   (setq _arm_no (round __arm_no))
   (setq _state_code (round __state_code))
   (setq _state_subcode (round __state_subcode))
   self)
  (:arm_no
   (&optional __arm_no)
   (if __arm_no (setq _arm_no __arm_no)) _arm_no)
  (:state_code
   (&optional __state_code)
   (if __state_code (setq _state_code __state_code)) _state_code)
  (:state_subcode
   (&optional __state_subcode)
   (if __state_subcode (setq _state_subcode __state_subcode)) _state_subcode)
  (:serialization-length
   ()
   (+
    ;; uint32 _arm_no
    4
    ;; uint32 _state_code
    4
    ;; uint32 _state_subcode
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _arm_no
       (write-long _arm_no s)
     ;; uint32 _state_code
       (write-long _state_code s)
     ;; uint32 _state_subcode
       (write-long _state_subcode s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _arm_no
     (setq _arm_no (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _state_code
     (setq _state_code (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _state_subcode
     (setq _state_subcode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get denso_cobotta_driver::RobotState :md5sum-) "135adb9a590743fac44eca4fa4af87bc")
(setf (get denso_cobotta_driver::RobotState :datatype-) "denso_cobotta_driver/RobotState")
(setf (get denso_cobotta_driver::RobotState :definition-)
      "uint32 arm_no
uint32 state_code
uint32 state_subcode

")



(provide :denso_cobotta_driver/RobotState "135adb9a590743fac44eca4fa4af87bc")


