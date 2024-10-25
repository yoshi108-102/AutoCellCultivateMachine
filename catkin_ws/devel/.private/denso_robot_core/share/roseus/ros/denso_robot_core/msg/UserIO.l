;; Auto-generated. Do not edit!


(when (boundp 'denso_robot_core::UserIO)
  (if (not (find-package "DENSO_ROBOT_CORE"))
    (make-package "DENSO_ROBOT_CORE"))
  (shadow 'UserIO (find-package "DENSO_ROBOT_CORE")))
(unless (find-package "DENSO_ROBOT_CORE::USERIO")
  (make-package "DENSO_ROBOT_CORE::USERIO"))

(in-package "ROS")
;;//! \htmlinclude UserIO.msg.html


(intern "*MIN_USERIO_OFFSET*" (find-package "DENSO_ROBOT_CORE::USERIO"))
(shadow '*MIN_USERIO_OFFSET* (find-package "DENSO_ROBOT_CORE::USERIO"))
(defconstant denso_robot_core::UserIO::*MIN_USERIO_OFFSET* 128)
(intern "*USERIO_ALIGNMENT*" (find-package "DENSO_ROBOT_CORE::USERIO"))
(shadow '*USERIO_ALIGNMENT* (find-package "DENSO_ROBOT_CORE::USERIO"))
(defconstant denso_robot_core::UserIO::*USERIO_ALIGNMENT* 8)

(defun denso_robot_core::UserIO-to-symbol (const)
  (cond
        ((= const 128) 'denso_robot_core::UserIO::*MIN_USERIO_OFFSET*)
        ((= const 8) 'denso_robot_core::UserIO::*USERIO_ALIGNMENT*)
        (t nil)))

(defclass denso_robot_core::UserIO
  :super ros::object
  :slots (_offset _size _value ))

(defmethod denso_robot_core::UserIO
  (:init
   (&key
    ((:offset __offset) 0)
    ((:size __size) 0)
    ((:value __value) (make-array 0 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _offset (round __offset))
   (setq _size (round __size))
   (setq _value __value)
   self)
  (:offset
   (&optional __offset)
   (if __offset (setq _offset __offset)) _offset)
  (:size
   (&optional __size)
   (if __size (setq _size __size)) _size)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:serialization-length
   ()
   (+
    ;; int32 _offset
    4
    ;; int32 _size
    4
    ;; uint8[] _value
    (* 1    (length _value)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _offset
       (write-long _offset s)
     ;; int32 _size
       (write-long _size s)
     ;; uint8[] _value
     (write-long (length _value) s)
     (princ _value s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _offset
     (setq _offset (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _size
     (setq _size (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint8[] _value
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _value (make-array n :element-type :char))
     (replace _value buf :start2 ptr-) (incf ptr- n))
   ;;
   self)
  )

(setf (get denso_robot_core::UserIO :md5sum-) "eff77a868fe4ad5d8084dd8ba2f71ce3")
(setf (get denso_robot_core::UserIO :datatype-) "denso_robot_core/UserIO")
(setf (get denso_robot_core::UserIO :definition-)
      "int32 MIN_USERIO_OFFSET=128
int32 USERIO_ALIGNMENT=8

int32 offset
int32 size
uint8[] value


")



(provide :denso_robot_core/UserIO "eff77a868fe4ad5d8084dd8ba2f71ce3")


