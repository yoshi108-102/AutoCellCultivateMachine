;; Auto-generated. Do not edit!


(when (boundp 'denso_cobotta_driver::ClearError)
  (if (not (find-package "DENSO_COBOTTA_DRIVER"))
    (make-package "DENSO_COBOTTA_DRIVER"))
  (shadow 'ClearError (find-package "DENSO_COBOTTA_DRIVER")))
(unless (find-package "DENSO_COBOTTA_DRIVER::CLEARERROR")
  (make-package "DENSO_COBOTTA_DRIVER::CLEARERROR"))
(unless (find-package "DENSO_COBOTTA_DRIVER::CLEARERRORREQUEST")
  (make-package "DENSO_COBOTTA_DRIVER::CLEARERRORREQUEST"))
(unless (find-package "DENSO_COBOTTA_DRIVER::CLEARERRORRESPONSE")
  (make-package "DENSO_COBOTTA_DRIVER::CLEARERRORRESPONSE"))

(in-package "ROS")





(defclass denso_cobotta_driver::ClearErrorRequest
  :super ros::object
  :slots ())

(defmethod denso_cobotta_driver::ClearErrorRequest
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

(defclass denso_cobotta_driver::ClearErrorResponse
  :super ros::object
  :slots (_success ))

(defmethod denso_cobotta_driver::ClearErrorResponse
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

(defclass denso_cobotta_driver::ClearError
  :super ros::object
  :slots ())

(setf (get denso_cobotta_driver::ClearError :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get denso_cobotta_driver::ClearError :datatype-) "denso_cobotta_driver/ClearError")
(setf (get denso_cobotta_driver::ClearError :request) denso_cobotta_driver::ClearErrorRequest)
(setf (get denso_cobotta_driver::ClearError :response) denso_cobotta_driver::ClearErrorResponse)

(defmethod denso_cobotta_driver::ClearErrorRequest
  (:response () (instance denso_cobotta_driver::ClearErrorResponse :init)))

(setf (get denso_cobotta_driver::ClearErrorRequest :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get denso_cobotta_driver::ClearErrorRequest :datatype-) "denso_cobotta_driver/ClearErrorRequest")
(setf (get denso_cobotta_driver::ClearErrorRequest :definition-)
      "---
bool success

")

(setf (get denso_cobotta_driver::ClearErrorResponse :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get denso_cobotta_driver::ClearErrorResponse :datatype-) "denso_cobotta_driver/ClearErrorResponse")
(setf (get denso_cobotta_driver::ClearErrorResponse :definition-)
      "---
bool success

")



(provide :denso_cobotta_driver/ClearError "358e233cde0c8a8bcfea4ce193f8fc15")


