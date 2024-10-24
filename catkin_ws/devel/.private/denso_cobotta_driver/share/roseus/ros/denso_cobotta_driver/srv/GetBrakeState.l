;; Auto-generated. Do not edit!


(when (boundp 'denso_cobotta_driver::GetBrakeState)
  (if (not (find-package "DENSO_COBOTTA_DRIVER"))
    (make-package "DENSO_COBOTTA_DRIVER"))
  (shadow 'GetBrakeState (find-package "DENSO_COBOTTA_DRIVER")))
(unless (find-package "DENSO_COBOTTA_DRIVER::GETBRAKESTATE")
  (make-package "DENSO_COBOTTA_DRIVER::GETBRAKESTATE"))
(unless (find-package "DENSO_COBOTTA_DRIVER::GETBRAKESTATEREQUEST")
  (make-package "DENSO_COBOTTA_DRIVER::GETBRAKESTATEREQUEST"))
(unless (find-package "DENSO_COBOTTA_DRIVER::GETBRAKESTATERESPONSE")
  (make-package "DENSO_COBOTTA_DRIVER::GETBRAKESTATERESPONSE"))

(in-package "ROS")





(defclass denso_cobotta_driver::GetBrakeStateRequest
  :super ros::object
  :slots ())

(defmethod denso_cobotta_driver::GetBrakeStateRequest
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

(defclass denso_cobotta_driver::GetBrakeStateResponse
  :super ros::object
  :slots (_state _success ))

(defmethod denso_cobotta_driver::GetBrakeStateResponse
  (:init
   (&key
    ((:state __state) (let (r) (dotimes (i 0) (push nil r)) r))
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _state __state)
   (setq _success __success)
   self)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool[] _state
    (* 1    (length _state)) 4
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool[] _state
     (write-long (length _state) s)
     (dotimes (i (length _state))
       (if (elt _state i) (write-byte -1 s) (write-byte 0 s))
       )
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool[] _state
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _state (make-list n))
     (dotimes (i n)
     (setf (elt _state i) (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
     ))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass denso_cobotta_driver::GetBrakeState
  :super ros::object
  :slots ())

(setf (get denso_cobotta_driver::GetBrakeState :md5sum-) "aafd640535ae055e319908df5e1e05da")
(setf (get denso_cobotta_driver::GetBrakeState :datatype-) "denso_cobotta_driver/GetBrakeState")
(setf (get denso_cobotta_driver::GetBrakeState :request) denso_cobotta_driver::GetBrakeStateRequest)
(setf (get denso_cobotta_driver::GetBrakeState :response) denso_cobotta_driver::GetBrakeStateResponse)

(defmethod denso_cobotta_driver::GetBrakeStateRequest
  (:response () (instance denso_cobotta_driver::GetBrakeStateResponse :init)))

(setf (get denso_cobotta_driver::GetBrakeStateRequest :md5sum-) "aafd640535ae055e319908df5e1e05da")
(setf (get denso_cobotta_driver::GetBrakeStateRequest :datatype-) "denso_cobotta_driver/GetBrakeStateRequest")
(setf (get denso_cobotta_driver::GetBrakeStateRequest :definition-)
      "---
bool[] state
bool success

")

(setf (get denso_cobotta_driver::GetBrakeStateResponse :md5sum-) "aafd640535ae055e319908df5e1e05da")
(setf (get denso_cobotta_driver::GetBrakeStateResponse :datatype-) "denso_cobotta_driver/GetBrakeStateResponse")
(setf (get denso_cobotta_driver::GetBrakeStateResponse :definition-)
      "---
bool[] state
bool success

")



(provide :denso_cobotta_driver/GetBrakeState "aafd640535ae055e319908df5e1e05da")


