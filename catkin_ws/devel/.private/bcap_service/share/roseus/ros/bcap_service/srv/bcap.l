;; Auto-generated. Do not edit!


(when (boundp 'bcap_service::bcap)
  (if (not (find-package "BCAP_SERVICE"))
    (make-package "BCAP_SERVICE"))
  (shadow 'bcap (find-package "BCAP_SERVICE")))
(unless (find-package "BCAP_SERVICE::BCAP")
  (make-package "BCAP_SERVICE::BCAP"))
(unless (find-package "BCAP_SERVICE::BCAPREQUEST")
  (make-package "BCAP_SERVICE::BCAPREQUEST"))
(unless (find-package "BCAP_SERVICE::BCAPRESPONSE")
  (make-package "BCAP_SERVICE::BCAPRESPONSE"))

(in-package "ROS")





(defclass bcap_service::bcapRequest
  :super ros::object
  :slots (_func_id _vntArgs ))

(defmethod bcap_service::bcapRequest
  (:init
   (&key
    ((:func_id __func_id) 0)
    ((:vntArgs __vntArgs) ())
    )
   (send-super :init)
   (setq _func_id (round __func_id))
   (setq _vntArgs __vntArgs)
   self)
  (:func_id
   (&optional __func_id)
   (if __func_id (setq _func_id __func_id)) _func_id)
  (:vntArgs
   (&rest __vntArgs)
   (if (keywordp (car __vntArgs))
       (send* _vntArgs __vntArgs)
     (progn
       (if __vntArgs (setq _vntArgs (car __vntArgs)))
       _vntArgs)))
  (:serialization-length
   ()
   (+
    ;; int32 _func_id
    4
    ;; bcap_service/variant[] _vntArgs
    (apply #'+ (send-all _vntArgs :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _func_id
       (write-long _func_id s)
     ;; bcap_service/variant[] _vntArgs
     (write-long (length _vntArgs) s)
     (dolist (elem _vntArgs)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _func_id
     (setq _func_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bcap_service/variant[] _vntArgs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _vntArgs (let (r) (dotimes (i n) (push (instance bcap_service::variant :init) r)) r))
     (dolist (elem- _vntArgs)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(defclass bcap_service::bcapResponse
  :super ros::object
  :slots (_HRESULT _vntRet ))

(defmethod bcap_service::bcapResponse
  (:init
   (&key
    ((:HRESULT __HRESULT) 0)
    ((:vntRet __vntRet) (instance bcap_service::variant :init))
    )
   (send-super :init)
   (setq _HRESULT (round __HRESULT))
   (setq _vntRet __vntRet)
   self)
  (:HRESULT
   (&optional __HRESULT)
   (if __HRESULT (setq _HRESULT __HRESULT)) _HRESULT)
  (:vntRet
   (&rest __vntRet)
   (if (keywordp (car __vntRet))
       (send* _vntRet __vntRet)
     (progn
       (if __vntRet (setq _vntRet (car __vntRet)))
       _vntRet)))
  (:serialization-length
   ()
   (+
    ;; int32 _HRESULT
    4
    ;; bcap_service/variant _vntRet
    (send _vntRet :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _HRESULT
       (write-long _HRESULT s)
     ;; bcap_service/variant _vntRet
       (send _vntRet :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _HRESULT
     (setq _HRESULT (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bcap_service/variant _vntRet
     (send _vntRet :deserialize buf ptr-) (incf ptr- (send _vntRet :serialization-length))
   ;;
   self)
  )

(defclass bcap_service::bcap
  :super ros::object
  :slots ())

(setf (get bcap_service::bcap :md5sum-) "d7da50225be5d246d6e3baaab811da16")
(setf (get bcap_service::bcap :datatype-) "bcap_service/bcap")
(setf (get bcap_service::bcap :request) bcap_service::bcapRequest)
(setf (get bcap_service::bcap :response) bcap_service::bcapResponse)

(defmethod bcap_service::bcapRequest
  (:response () (instance bcap_service::bcapResponse :init)))

(setf (get bcap_service::bcapRequest :md5sum-) "d7da50225be5d246d6e3baaab811da16")
(setf (get bcap_service::bcapRequest :datatype-) "bcap_service/bcapRequest")
(setf (get bcap_service::bcapRequest :definition-)
      "int32 func_id
variant[] vntArgs

================================================================================
MSG: bcap_service/variant
int16 vt
string value
---
int32 HRESULT
variant vntRet

================================================================================
MSG: bcap_service/variant
int16 vt
string value
")

(setf (get bcap_service::bcapResponse :md5sum-) "d7da50225be5d246d6e3baaab811da16")
(setf (get bcap_service::bcapResponse :datatype-) "bcap_service/bcapResponse")
(setf (get bcap_service::bcapResponse :definition-)
      "int32 func_id
variant[] vntArgs

================================================================================
MSG: bcap_service/variant
int16 vt
string value
---
int32 HRESULT
variant vntRet

================================================================================
MSG: bcap_service/variant
int16 vt
string value
")



(provide :bcap_service/bcap "d7da50225be5d246d6e3baaab811da16")


