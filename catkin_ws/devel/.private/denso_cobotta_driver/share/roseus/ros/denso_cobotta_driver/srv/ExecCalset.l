;; Auto-generated. Do not edit!


(when (boundp 'denso_cobotta_driver::ExecCalset)
  (if (not (find-package "DENSO_COBOTTA_DRIVER"))
    (make-package "DENSO_COBOTTA_DRIVER"))
  (shadow 'ExecCalset (find-package "DENSO_COBOTTA_DRIVER")))
(unless (find-package "DENSO_COBOTTA_DRIVER::EXECCALSET")
  (make-package "DENSO_COBOTTA_DRIVER::EXECCALSET"))
(unless (find-package "DENSO_COBOTTA_DRIVER::EXECCALSETREQUEST")
  (make-package "DENSO_COBOTTA_DRIVER::EXECCALSETREQUEST"))
(unless (find-package "DENSO_COBOTTA_DRIVER::EXECCALSETRESPONSE")
  (make-package "DENSO_COBOTTA_DRIVER::EXECCALSETRESPONSE"))

(in-package "ROS")





(defclass denso_cobotta_driver::ExecCalsetRequest
  :super ros::object
  :slots ())

(defmethod denso_cobotta_driver::ExecCalsetRequest
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

(defclass denso_cobotta_driver::ExecCalsetResponse
  :super ros::object
  :slots (_success ))

(defmethod denso_cobotta_driver::ExecCalsetResponse
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

(defclass denso_cobotta_driver::ExecCalset
  :super ros::object
  :slots ())

(setf (get denso_cobotta_driver::ExecCalset :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get denso_cobotta_driver::ExecCalset :datatype-) "denso_cobotta_driver/ExecCalset")
(setf (get denso_cobotta_driver::ExecCalset :request) denso_cobotta_driver::ExecCalsetRequest)
(setf (get denso_cobotta_driver::ExecCalset :response) denso_cobotta_driver::ExecCalsetResponse)

(defmethod denso_cobotta_driver::ExecCalsetRequest
  (:response () (instance denso_cobotta_driver::ExecCalsetResponse :init)))

(setf (get denso_cobotta_driver::ExecCalsetRequest :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get denso_cobotta_driver::ExecCalsetRequest :datatype-) "denso_cobotta_driver/ExecCalsetRequest")
(setf (get denso_cobotta_driver::ExecCalsetRequest :definition-)
      "---
bool success

")

(setf (get denso_cobotta_driver::ExecCalsetResponse :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get denso_cobotta_driver::ExecCalsetResponse :datatype-) "denso_cobotta_driver/ExecCalsetResponse")
(setf (get denso_cobotta_driver::ExecCalsetResponse :definition-)
      "---
bool success

")



(provide :denso_cobotta_driver/ExecCalset "358e233cde0c8a8bcfea4ce193f8fc15")


