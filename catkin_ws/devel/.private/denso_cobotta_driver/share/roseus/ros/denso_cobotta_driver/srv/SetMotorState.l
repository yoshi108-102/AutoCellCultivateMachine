;; Auto-generated. Do not edit!


(when (boundp 'denso_cobotta_driver::SetMotorState)
  (if (not (find-package "DENSO_COBOTTA_DRIVER"))
    (make-package "DENSO_COBOTTA_DRIVER"))
  (shadow 'SetMotorState (find-package "DENSO_COBOTTA_DRIVER")))
(unless (find-package "DENSO_COBOTTA_DRIVER::SETMOTORSTATE")
  (make-package "DENSO_COBOTTA_DRIVER::SETMOTORSTATE"))
(unless (find-package "DENSO_COBOTTA_DRIVER::SETMOTORSTATEREQUEST")
  (make-package "DENSO_COBOTTA_DRIVER::SETMOTORSTATEREQUEST"))
(unless (find-package "DENSO_COBOTTA_DRIVER::SETMOTORSTATERESPONSE")
  (make-package "DENSO_COBOTTA_DRIVER::SETMOTORSTATERESPONSE"))

(in-package "ROS")





(defclass denso_cobotta_driver::SetMotorStateRequest
  :super ros::object
  :slots (_state ))

(defmethod denso_cobotta_driver::SetMotorStateRequest
  (:init
   (&key
    ((:state __state) nil)
    )
   (send-super :init)
   (setq _state __state)
   self)
  (:state
   (&optional (__state :null))
   (if (not (eq __state :null)) (setq _state __state)) _state)
  (:serialization-length
   ()
   (+
    ;; bool _state
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _state
       (if _state (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _state
     (setq _state (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass denso_cobotta_driver::SetMotorStateResponse
  :super ros::object
  :slots (_success ))

(defmethod denso_cobotta_driver::SetMotorStateResponse
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

(defclass denso_cobotta_driver::SetMotorState
  :super ros::object
  :slots ())

(setf (get denso_cobotta_driver::SetMotorState :md5sum-) "4581db74aae4efc6534413a8b210908c")
(setf (get denso_cobotta_driver::SetMotorState :datatype-) "denso_cobotta_driver/SetMotorState")
(setf (get denso_cobotta_driver::SetMotorState :request) denso_cobotta_driver::SetMotorStateRequest)
(setf (get denso_cobotta_driver::SetMotorState :response) denso_cobotta_driver::SetMotorStateResponse)

(defmethod denso_cobotta_driver::SetMotorStateRequest
  (:response () (instance denso_cobotta_driver::SetMotorStateResponse :init)))

(setf (get denso_cobotta_driver::SetMotorStateRequest :md5sum-) "4581db74aae4efc6534413a8b210908c")
(setf (get denso_cobotta_driver::SetMotorStateRequest :datatype-) "denso_cobotta_driver/SetMotorStateRequest")
(setf (get denso_cobotta_driver::SetMotorStateRequest :definition-)
      "bool state
---
bool success

")

(setf (get denso_cobotta_driver::SetMotorStateResponse :md5sum-) "4581db74aae4efc6534413a8b210908c")
(setf (get denso_cobotta_driver::SetMotorStateResponse :datatype-) "denso_cobotta_driver/SetMotorStateResponse")
(setf (get denso_cobotta_driver::SetMotorStateResponse :definition-)
      "bool state
---
bool success

")



(provide :denso_cobotta_driver/SetMotorState "4581db74aae4efc6534413a8b210908c")


