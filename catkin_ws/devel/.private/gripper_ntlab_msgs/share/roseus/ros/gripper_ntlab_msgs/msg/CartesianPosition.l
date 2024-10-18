;; Auto-generated. Do not edit!


(when (boundp 'gripper_ntlab_msgs::CartesianPosition)
  (if (not (find-package "GRIPPER_NTLAB_MSGS"))
    (make-package "GRIPPER_NTLAB_MSGS"))
  (shadow 'CartesianPosition (find-package "GRIPPER_NTLAB_MSGS")))
(unless (find-package "GRIPPER_NTLAB_MSGS::CARTESIANPOSITION")
  (make-package "GRIPPER_NTLAB_MSGS::CARTESIANPOSITION"))

(in-package "ROS")
;;//! \htmlinclude CartesianPosition.msg.html


(defclass gripper_ntlab_msgs::CartesianPosition
  :super ros::object
  :slots (_x1 _y1 _x2 _y2 _rad _buffer _torque ))

(defmethod gripper_ntlab_msgs::CartesianPosition
  (:init
   (&key
    ((:x1 __x1) 0.0)
    ((:y1 __y1) 0.0)
    ((:x2 __x2) 0.0)
    ((:y2 __y2) 0.0)
    ((:rad __rad) 0.0)
    ((:buffer __buffer) 0)
    ((:torque __torque) nil)
    )
   (send-super :init)
   (setq _x1 (float __x1))
   (setq _y1 (float __y1))
   (setq _x2 (float __x2))
   (setq _y2 (float __y2))
   (setq _rad (float __rad))
   (setq _buffer (round __buffer))
   (setq _torque __torque)
   self)
  (:x1
   (&optional __x1)
   (if __x1 (setq _x1 __x1)) _x1)
  (:y1
   (&optional __y1)
   (if __y1 (setq _y1 __y1)) _y1)
  (:x2
   (&optional __x2)
   (if __x2 (setq _x2 __x2)) _x2)
  (:y2
   (&optional __y2)
   (if __y2 (setq _y2 __y2)) _y2)
  (:rad
   (&optional __rad)
   (if __rad (setq _rad __rad)) _rad)
  (:buffer
   (&optional __buffer)
   (if __buffer (setq _buffer __buffer)) _buffer)
  (:torque
   (&optional (__torque :null))
   (if (not (eq __torque :null)) (setq _torque __torque)) _torque)
  (:serialization-length
   ()
   (+
    ;; float64 _x1
    8
    ;; float64 _y1
    8
    ;; float64 _x2
    8
    ;; float64 _y2
    8
    ;; float64 _rad
    8
    ;; uint8 _buffer
    1
    ;; bool _torque
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _x1
       (sys::poke _x1 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y1
       (sys::poke _y1 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _x2
       (sys::poke _x2 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y2
       (sys::poke _y2 (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _rad
       (sys::poke _rad (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; uint8 _buffer
       (write-byte _buffer s)
     ;; bool _torque
       (if _torque (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _x1
     (setq _x1 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y1
     (setq _y1 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _x2
     (setq _x2 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y2
     (setq _y2 (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _rad
     (setq _rad (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; uint8 _buffer
     (setq _buffer (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; bool _torque
     (setq _torque (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get gripper_ntlab_msgs::CartesianPosition :md5sum-) "0f9f2aa44155913dda5f4deaeec35ddd")
(setf (get gripper_ntlab_msgs::CartesianPosition :datatype-) "gripper_ntlab_msgs/CartesianPosition")
(setf (get gripper_ntlab_msgs::CartesianPosition :definition-)
      "float64 x1
float64 y1
float64 x2
float64 y2
float64 rad
uint8 buffer
bool torque
")



(provide :gripper_ntlab_msgs/CartesianPosition "0f9f2aa44155913dda5f4deaeec35ddd")


