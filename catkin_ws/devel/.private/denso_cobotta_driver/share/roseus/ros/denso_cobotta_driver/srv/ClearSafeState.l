;; Auto-generated. Do not edit!


(when (boundp 'denso_cobotta_driver::ClearSafeState)
  (if (not (find-package "DENSO_COBOTTA_DRIVER"))
    (make-package "DENSO_COBOTTA_DRIVER"))
  (shadow 'ClearSafeState (find-package "DENSO_COBOTTA_DRIVER")))
(unless (find-package "DENSO_COBOTTA_DRIVER::CLEARSAFESTATE")
  (make-package "DENSO_COBOTTA_DRIVER::CLEARSAFESTATE"))
(unless (find-package "DENSO_COBOTTA_DRIVER::CLEARSAFESTATEREQUEST")
  (make-package "DENSO_COBOTTA_DRIVER::CLEARSAFESTATEREQUEST"))
(unless (find-package "DENSO_COBOTTA_DRIVER::CLEARSAFESTATERESPONSE")
  (make-package "DENSO_COBOTTA_DRIVER::CLEARSAFESTATERESPONSE"))

(in-package "ROS")





(defclass denso_cobotta_driver::ClearSafeStateRequest
  :super ros::object
  :slots ())

(defmethod denso_cobotta_driver::ClearSafeStateRequest
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

(defclass denso_cobotta_driver::ClearSafeStateResponse
  :super ros::object
  :slots (_success ))

(defmethod denso_cobotta_driver::ClearSafeStateResponse
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

(defclass denso_cobotta_driver::ClearSafeState
  :super ros::object
  :slots ())

(setf (get denso_cobotta_driver::ClearSafeState :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get denso_cobotta_driver::ClearSafeState :datatype-) "denso_cobotta_driver/ClearSafeState")
(setf (get denso_cobotta_driver::ClearSafeState :request) denso_cobotta_driver::ClearSafeStateRequest)
(setf (get denso_cobotta_driver::ClearSafeState :response) denso_cobotta_driver::ClearSafeStateResponse)

(defmethod denso_cobotta_driver::ClearSafeStateRequest
  (:response () (instance denso_cobotta_driver::ClearSafeStateResponse :init)))

(setf (get denso_cobotta_driver::ClearSafeStateRequest :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get denso_cobotta_driver::ClearSafeStateRequest :datatype-) "denso_cobotta_driver/ClearSafeStateRequest")
(setf (get denso_cobotta_driver::ClearSafeStateRequest :definition-)
      "---
bool success

")

(setf (get denso_cobotta_driver::ClearSafeStateResponse :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get denso_cobotta_driver::ClearSafeStateResponse :datatype-) "denso_cobotta_driver/ClearSafeStateResponse")
(setf (get denso_cobotta_driver::ClearSafeStateResponse :definition-)
      "---
bool success

")



(provide :denso_cobotta_driver/ClearSafeState "358e233cde0c8a8bcfea4ce193f8fc15")


