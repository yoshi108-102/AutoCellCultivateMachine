;; Auto-generated. Do not edit!


(when (boundp 'denso_cobotta_driver::SetLEDState)
  (if (not (find-package "DENSO_COBOTTA_DRIVER"))
    (make-package "DENSO_COBOTTA_DRIVER"))
  (shadow 'SetLEDState (find-package "DENSO_COBOTTA_DRIVER")))
(unless (find-package "DENSO_COBOTTA_DRIVER::SETLEDSTATE")
  (make-package "DENSO_COBOTTA_DRIVER::SETLEDSTATE"))
(unless (find-package "DENSO_COBOTTA_DRIVER::SETLEDSTATEREQUEST")
  (make-package "DENSO_COBOTTA_DRIVER::SETLEDSTATEREQUEST"))
(unless (find-package "DENSO_COBOTTA_DRIVER::SETLEDSTATERESPONSE")
  (make-package "DENSO_COBOTTA_DRIVER::SETLEDSTATERESPONSE"))

(in-package "ROS")





(defclass denso_cobotta_driver::SetLEDStateRequest
  :super ros::object
  :slots (_red _green _blue _blink_rate ))

(defmethod denso_cobotta_driver::SetLEDStateRequest
  (:init
   (&key
    ((:red __red) 0)
    ((:green __green) 0)
    ((:blue __blue) 0)
    ((:blink_rate __blink_rate) 0)
    )
   (send-super :init)
   (setq _red (round __red))
   (setq _green (round __green))
   (setq _blue (round __blue))
   (setq _blink_rate (round __blink_rate))
   self)
  (:red
   (&optional __red)
   (if __red (setq _red __red)) _red)
  (:green
   (&optional __green)
   (if __green (setq _green __green)) _green)
  (:blue
   (&optional __blue)
   (if __blue (setq _blue __blue)) _blue)
  (:blink_rate
   (&optional __blink_rate)
   (if __blink_rate (setq _blink_rate __blink_rate)) _blink_rate)
  (:serialization-length
   ()
   (+
    ;; uint8 _red
    1
    ;; uint8 _green
    1
    ;; uint8 _blue
    1
    ;; uint8 _blink_rate
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _red
       (write-byte _red s)
     ;; uint8 _green
       (write-byte _green s)
     ;; uint8 _blue
       (write-byte _blue s)
     ;; uint8 _blink_rate
       (write-byte _blink_rate s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _red
     (setq _red (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _green
     (setq _green (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _blue
     (setq _blue (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _blink_rate
     (setq _blink_rate (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass denso_cobotta_driver::SetLEDStateResponse
  :super ros::object
  :slots (_success ))

(defmethod denso_cobotta_driver::SetLEDStateResponse
  (:init
   (&key
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass denso_cobotta_driver::SetLEDState
  :super ros::object
  :slots ())

(setf (get denso_cobotta_driver::SetLEDState :md5sum-) "2ae38ea1f2419ff3e6383563a0531fc9")
(setf (get denso_cobotta_driver::SetLEDState :datatype-) "denso_cobotta_driver/SetLEDState")
(setf (get denso_cobotta_driver::SetLEDState :request) denso_cobotta_driver::SetLEDStateRequest)
(setf (get denso_cobotta_driver::SetLEDState :response) denso_cobotta_driver::SetLEDStateResponse)

(defmethod denso_cobotta_driver::SetLEDStateRequest
  (:response () (instance denso_cobotta_driver::SetLEDStateResponse :init)))

(setf (get denso_cobotta_driver::SetLEDStateRequest :md5sum-) "2ae38ea1f2419ff3e6383563a0531fc9")
(setf (get denso_cobotta_driver::SetLEDStateRequest :datatype-) "denso_cobotta_driver/SetLEDStateRequest")
(setf (get denso_cobotta_driver::SetLEDStateRequest :definition-)
      "uint8 red
uint8 green
uint8 blue
uint8 blink_rate
---
bool success

")

(setf (get denso_cobotta_driver::SetLEDStateResponse :md5sum-) "2ae38ea1f2419ff3e6383563a0531fc9")
(setf (get denso_cobotta_driver::SetLEDStateResponse :datatype-) "denso_cobotta_driver/SetLEDStateResponse")
(setf (get denso_cobotta_driver::SetLEDStateResponse :definition-)
      "uint8 red
uint8 green
uint8 blue
uint8 blink_rate
---
bool success

")



(provide :denso_cobotta_driver/SetLEDState "2ae38ea1f2419ff3e6383563a0531fc9")


