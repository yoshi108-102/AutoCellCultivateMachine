;; Auto-generated. Do not edit!


(when (boundp 'denso_cobotta_driver::SafeState)
  (if (not (find-package "DENSO_COBOTTA_DRIVER"))
    (make-package "DENSO_COBOTTA_DRIVER"))
  (shadow 'SafeState (find-package "DENSO_COBOTTA_DRIVER")))
(unless (find-package "DENSO_COBOTTA_DRIVER::SAFESTATE")
  (make-package "DENSO_COBOTTA_DRIVER::SAFESTATE"))

(in-package "ROS")
;;//! \htmlinclude SafeState.msg.html


(defclass denso_cobotta_driver::SafeState
  :super ros::object
  :slots (_state_code _state_subcode ))

(defmethod denso_cobotta_driver::SafeState
  (:init
   (&key
    ((:state_code __state_code) 0)
    ((:state_subcode __state_subcode) 0)
    )
   (send-super :init)
   (setq _state_code (round __state_code))
   (setq _state_subcode (round __state_subcode))
   self)
  (:state_code
   (&optional __state_code)
   (if __state_code (setq _state_code __state_code)) _state_code)
  (:state_subcode
   (&optional __state_subcode)
   (if __state_subcode (setq _state_subcode __state_subcode)) _state_subcode)
  (:serialization-length
   ()
   (+
    ;; uint32 _state_code
    4
    ;; uint32 _state_subcode
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _state_code
       (write-long _state_code s)
     ;; uint32 _state_subcode
       (write-long _state_subcode s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _state_code
     (setq _state_code (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _state_subcode
     (setq _state_subcode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get denso_cobotta_driver::SafeState :md5sum-) "c6778351a17e3634b544e31281fc203a")
(setf (get denso_cobotta_driver::SafeState :datatype-) "denso_cobotta_driver/SafeState")
(setf (get denso_cobotta_driver::SafeState :definition-)
      "uint32 state_code
uint32 state_subcode

")



(provide :denso_cobotta_driver/SafeState "c6778351a17e3634b544e31281fc203a")


