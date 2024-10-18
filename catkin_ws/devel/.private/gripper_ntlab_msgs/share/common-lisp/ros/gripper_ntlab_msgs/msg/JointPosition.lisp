; Auto-generated. Do not edit!


(cl:in-package gripper_ntlab_msgs-msg)


;//! \htmlinclude JointPosition.msg.html

(cl:defclass <JointPosition> (roslisp-msg-protocol:ros-message)
  ((position
    :reader position
    :initarg :position
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (mode
    :reader mode
    :initarg :mode
    :type cl:fixnum
    :initform 0))
)

(cl:defclass JointPosition (<JointPosition>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <JointPosition>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'JointPosition)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gripper_ntlab_msgs-msg:<JointPosition> is deprecated: use gripper_ntlab_msgs-msg:JointPosition instead.")))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <JointPosition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gripper_ntlab_msgs-msg:position-val is deprecated.  Use gripper_ntlab_msgs-msg:position instead.")
  (position m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <JointPosition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gripper_ntlab_msgs-msg:mode-val is deprecated.  Use gripper_ntlab_msgs-msg:mode instead.")
  (mode m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <JointPosition>) ostream)
  "Serializes a message object of type '<JointPosition>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'position))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'position))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'mode)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <JointPosition>) istream)
  "Deserializes a message object of type '<JointPosition>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'position) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'position)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits))))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'mode)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<JointPosition>)))
  "Returns string type for a message object of type '<JointPosition>"
  "gripper_ntlab_msgs/JointPosition")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'JointPosition)))
  "Returns string type for a message object of type 'JointPosition"
  "gripper_ntlab_msgs/JointPosition")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<JointPosition>)))
  "Returns md5sum for a message object of type '<JointPosition>"
  "42665b9cfa738929ee7f26a4db0bd85b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'JointPosition)))
  "Returns md5sum for a message object of type 'JointPosition"
  "42665b9cfa738929ee7f26a4db0bd85b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<JointPosition>)))
  "Returns full string definition for message of type '<JointPosition>"
  (cl:format cl:nil "float64[] position~%uint8 mode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'JointPosition)))
  "Returns full string definition for message of type 'JointPosition"
  (cl:format cl:nil "float64[] position~%uint8 mode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <JointPosition>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'position) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <JointPosition>))
  "Converts a ROS message object to a list"
  (cl:list 'JointPosition
    (cl:cons ':position (position msg))
    (cl:cons ':mode (mode msg))
))
