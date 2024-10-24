;; Auto-generated. Do not edit!


(when (boundp 'denso_cobotta_driver::ClearRobotError)
  (if (not (find-package "DENSO_COBOTTA_DRIVER"))
    (make-package "DENSO_COBOTTA_DRIVER"))
  (shadow 'ClearRobotError (find-package "DENSO_COBOTTA_DRIVER")))
(unless (find-package "DENSO_COBOTTA_DRIVER::CLEARROBOTERROR")
  (make-package "DENSO_COBOTTA_DRIVER::CLEARROBOTERROR"))
(unless (find-package "DENSO_COBOTTA_DRIVER::CLEARROBOTERRORREQUEST")
  (make-package "DENSO_COBOTTA_DRIVER::CLEARROBOTERRORREQUEST"))
(unless (find-package "DENSO_COBOTTA_DRIVER::CLEARROBOTERRORRESPONSE")
  (make-package "DENSO_COBOTTA_DRIVER::CLEARROBOTERRORRESPONSE"))

(in-package "ROS")





(defclass denso_cobotta_driver::ClearRobotErrorRequest
  :super ros::object
  :slots ())

(defmethod denso_cobotta_driver::ClearRobotErrorRequest
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

(defclass denso_cobotta_driver::ClearRobotErrorResponse
  :super ros::object
  :slots (_success ))

(defmethod denso_cobotta_driver::ClearRobotErrorResponse
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

(defclass denso_cobotta_driver::ClearRobotError
  :super ros::object
  :slots ())

(setf (get denso_cobotta_driver::ClearRobotError :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get denso_cobotta_driver::ClearRobotError :datatype-) "denso_cobotta_driver/ClearRobotError")
(setf (get denso_cobotta_driver::ClearRobotError :request) denso_cobotta_driver::ClearRobotErrorRequest)
(setf (get denso_cobotta_driver::ClearRobotError :response) denso_cobotta_driver::ClearRobotErrorResponse)

(defmethod denso_cobotta_driver::ClearRobotErrorRequest
  (:response () (instance denso_cobotta_driver::ClearRobotErrorResponse :init)))

(setf (get denso_cobotta_driver::ClearRobotErrorRequest :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get denso_cobotta_driver::ClearRobotErrorRequest :datatype-) "denso_cobotta_driver/ClearRobotErrorRequest")
(setf (get denso_cobotta_driver::ClearRobotErrorRequest :definition-)
      "---
bool success

")

(setf (get denso_cobotta_driver::ClearRobotErrorResponse :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get denso_cobotta_driver::ClearRobotErrorResponse :datatype-) "denso_cobotta_driver/ClearRobotErrorResponse")
(setf (get denso_cobotta_driver::ClearRobotErrorResponse :definition-)
      "---
bool success

")



(provide :denso_cobotta_driver/ClearRobotError "358e233cde0c8a8bcfea4ce193f8fc15")


