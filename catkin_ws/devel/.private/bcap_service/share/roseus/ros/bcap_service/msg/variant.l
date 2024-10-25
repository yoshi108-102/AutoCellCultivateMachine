;; Auto-generated. Do not edit!


(when (boundp 'bcap_service::variant)
  (if (not (find-package "BCAP_SERVICE"))
    (make-package "BCAP_SERVICE"))
  (shadow 'variant (find-package "BCAP_SERVICE")))
(unless (find-package "BCAP_SERVICE::VARIANT")
  (make-package "BCAP_SERVICE::VARIANT"))

(in-package "ROS")
;;//! \htmlinclude variant.msg.html


(defclass bcap_service::variant
  :super ros::object
  :slots (_vt _value ))

(defmethod bcap_service::variant
  (:init
   (&key
    ((:vt __vt) 0)
    ((:value __value) "")
    )
   (send-super :init)
   (setq _vt (round __vt))
   (setq _value (string __value))
   self)
  (:vt
   (&optional __vt)
   (if __vt (setq _vt __vt)) _vt)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; int16 _vt
    2
    ;; string _value
    4 (length _value)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int16 _vt
       (write-word _vt s)
     ;; string _value
       (write-long (length _value) s) (princ _value s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int16 _vt
     (setq _vt (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; string _value
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _value (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get bcap_service::variant :md5sum-) "0ff385ab5cb58d55d6c7b0d33e88693e")
(setf (get bcap_service::variant :datatype-) "bcap_service/variant")
(setf (get bcap_service::variant :definition-)
      "int16 vt
string value

")



(provide :bcap_service/variant "0ff385ab5cb58d55d6c7b0d33e88693e")


