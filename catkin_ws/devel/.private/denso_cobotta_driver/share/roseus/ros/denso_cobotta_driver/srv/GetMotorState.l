;; Auto-generated. Do not edit!


(when (boundp 'denso_cobotta_driver::GetMotorState)
  (if (not (find-package "DENSO_COBOTTA_DRIVER"))
    (make-package "DENSO_COBOTTA_DRIVER"))
  (shadow 'GetMotorState (find-package "DENSO_COBOTTA_DRIVER")))
(unless (find-package "DENSO_COBOTTA_DRIVER::GETMOTORSTATE")
  (make-package "DENSO_COBOTTA_DRIVER::GETMOTORSTATE"))
(unless (find-package "DENSO_COBOTTA_DRIVER::GETMOTORSTATEREQUEST")
  (make-package "DENSO_COBOTTA_DRIVER::GETMOTORSTATEREQUEST"))
(unless (find-package "DENSO_COBOTTA_DRIVER::GETMOTORSTATERESPONSE")
  (make-package "DENSO_COBOTTA_DRIVER::GETMOTORSTATERESPONSE"))

(in-package "ROS")





(defclass denso_cobotta_driver::GetMotorStateRequest
  :super ros::object
  :slots ())

(defmethod denso_cobotta_driver::GetMotorStateRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass denso_cobotta_driver::GetMotorStateResponse
  :super ros::object
  :slots (_state _success ))

(defmethod denso_cobotta_driver::GetMotorStateResponse
  (:init
   (&key
    ((:state __state) nil)
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _state __state)
   (setq _success __success)
   self)
  (:state
   (&optional (__state :null))
   (if (not (eq __state :null)) (setq _state __state)) _state)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _state
    1
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _state
       (if _state (write-byte -1 s) (write-byte 0 s))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _state
     (setq _state (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass denso_cobotta_driver::GetMotorState
  :super ros::object
  :slots ())

(setf (get denso_cobotta_driver::GetMotorState :md5sum-) "271f2b21ec71f675bf49eb4b1873d850")
(setf (get denso_cobotta_driver::GetMotorState :datatype-) "denso_cobotta_driver/GetMotorState")
(setf (get denso_cobotta_driver::GetMotorState :request) denso_cobotta_driver::GetMotorStateRequest)
(setf (get denso_cobotta_driver::GetMotorState :response) denso_cobotta_driver::GetMotorStateResponse)

(defmethod denso_cobotta_driver::GetMotorStateRequest
  (:response () (instance denso_cobotta_driver::GetMotorStateResponse :init)))

(setf (get denso_cobotta_driver::GetMotorStateRequest :md5sum-) "271f2b21ec71f675bf49eb4b1873d850")
(setf (get denso_cobotta_driver::GetMotorStateRequest :datatype-) "denso_cobotta_driver/GetMotorStateRequest")
(setf (get denso_cobotta_driver::GetMotorStateRequest :definition-)
      "---
bool state
bool success

")

(setf (get denso_cobotta_driver::GetMotorStateResponse :md5sum-) "271f2b21ec71f675bf49eb4b1873d850")
(setf (get denso_cobotta_driver::GetMotorStateResponse :datatype-) "denso_cobotta_driver/GetMotorStateResponse")
(setf (get denso_cobotta_driver::GetMotorStateResponse :definition-)
      "---
bool state
bool success

")



(provide :denso_cobotta_driver/GetMotorState "271f2b21ec71f675bf49eb4b1873d850")


