;; Auto-generated. Do not edit!


(when (boundp 'denso_cobotta_driver::SetBrakeState)
  (if (not (find-package "DENSO_COBOTTA_DRIVER"))
    (make-package "DENSO_COBOTTA_DRIVER"))
  (shadow 'SetBrakeState (find-package "DENSO_COBOTTA_DRIVER")))
(unless (find-package "DENSO_COBOTTA_DRIVER::SETBRAKESTATE")
  (make-package "DENSO_COBOTTA_DRIVER::SETBRAKESTATE"))
(unless (find-package "DENSO_COBOTTA_DRIVER::SETBRAKESTATEREQUEST")
  (make-package "DENSO_COBOTTA_DRIVER::SETBRAKESTATEREQUEST"))
(unless (find-package "DENSO_COBOTTA_DRIVER::SETBRAKESTATERESPONSE")
  (make-package "DENSO_COBOTTA_DRIVER::SETBRAKESTATERESPONSE"))

(in-package "ROS")





(defclass denso_cobotta_driver::SetBrakeStateRequest
  :super ros::object
  :slots (_state ))

(defmethod denso_cobotta_driver::SetBrakeStateRequest
  (:init
   (&key
    ((:state __state) (let (r) (dotimes (i 0) (push nil r)) r))
    )
   (send-super :init)
   (setq _state __state)
   self)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:serialization-length
   ()
   (+
    ;; bool[] _state
    (* 1    (length _state)) 4
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
   ;;
   self)
  )

(defclass denso_cobotta_driver::SetBrakeStateResponse
  :super ros::object
  :slots (_success ))

(defmethod denso_cobotta_driver::SetBrakeStateResponse
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

(defclass denso_cobotta_driver::SetBrakeState
  :super ros::object
  :slots ())

(setf (get denso_cobotta_driver::SetBrakeState :md5sum-) "ae7dda53a675ec4b8a49daeadb776d4c")
(setf (get denso_cobotta_driver::SetBrakeState :datatype-) "denso_cobotta_driver/SetBrakeState")
(setf (get denso_cobotta_driver::SetBrakeState :request) denso_cobotta_driver::SetBrakeStateRequest)
(setf (get denso_cobotta_driver::SetBrakeState :response) denso_cobotta_driver::SetBrakeStateResponse)

(defmethod denso_cobotta_driver::SetBrakeStateRequest
  (:response () (instance denso_cobotta_driver::SetBrakeStateResponse :init)))

(setf (get denso_cobotta_driver::SetBrakeStateRequest :md5sum-) "ae7dda53a675ec4b8a49daeadb776d4c")
(setf (get denso_cobotta_driver::SetBrakeStateRequest :datatype-) "denso_cobotta_driver/SetBrakeStateRequest")
(setf (get denso_cobotta_driver::SetBrakeStateRequest :definition-)
      "bool[] state
---
bool success

")

(setf (get denso_cobotta_driver::SetBrakeStateResponse :md5sum-) "ae7dda53a675ec4b8a49daeadb776d4c")
(setf (get denso_cobotta_driver::SetBrakeStateResponse :datatype-) "denso_cobotta_driver/SetBrakeStateResponse")
(setf (get denso_cobotta_driver::SetBrakeStateResponse :definition-)
      "bool[] state
---
bool success

")



(provide :denso_cobotta_driver/SetBrakeState "ae7dda53a675ec4b8a49daeadb776d4c")


