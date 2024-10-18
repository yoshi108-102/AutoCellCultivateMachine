; Auto-generated. Do not edit!


(cl:in-package denso_robot_core-msg)


;//! \htmlinclude UserIO.msg.html

(cl:defclass <UserIO> (roslisp-msg-protocol:ros-message)
  ((offset
    :reader offset
    :initarg :offset
    :type cl:integer
    :initform 0)
   (size
    :reader size
    :initarg :size
    :type cl:integer
    :initform 0)
   (value
    :reader value
    :initarg :value
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass UserIO (<UserIO>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UserIO>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UserIO)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_robot_core-msg:<UserIO> is deprecated: use denso_robot_core-msg:UserIO instead.")))

(cl:ensure-generic-function 'offset-val :lambda-list '(m))
(cl:defmethod offset-val ((m <UserIO>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:offset-val is deprecated.  Use denso_robot_core-msg:offset instead.")
  (offset m))

(cl:ensure-generic-function 'size-val :lambda-list '(m))
(cl:defmethod size-val ((m <UserIO>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:size-val is deprecated.  Use denso_robot_core-msg:size instead.")
  (size m))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <UserIO>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:value-val is deprecated.  Use denso_robot_core-msg:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<UserIO>)))
    "Constants for message type '<UserIO>"
  '((:MIN_USERIO_OFFSET . 128)
    (:USERIO_ALIGNMENT . 8))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'UserIO)))
    "Constants for message type 'UserIO"
  '((:MIN_USERIO_OFFSET . 128)
    (:USERIO_ALIGNMENT . 8))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UserIO>) ostream)
  "Serializes a message object of type '<UserIO>"
  (cl:let* ((signed (cl:slot-value msg 'offset)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'size)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'value))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UserIO>) istream)
  "Deserializes a message object of type '<UserIO>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'offset) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'size) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'value) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'value)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UserIO>)))
  "Returns string type for a message object of type '<UserIO>"
  "denso_robot_core/UserIO")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UserIO)))
  "Returns string type for a message object of type 'UserIO"
  "denso_robot_core/UserIO")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UserIO>)))
  "Returns md5sum for a message object of type '<UserIO>"
  "eff77a868fe4ad5d8084dd8ba2f71ce3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UserIO)))
  "Returns md5sum for a message object of type 'UserIO"
  "eff77a868fe4ad5d8084dd8ba2f71ce3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UserIO>)))
  "Returns full string definition for message of type '<UserIO>"
  (cl:format cl:nil "int32 MIN_USERIO_OFFSET=128~%int32 USERIO_ALIGNMENT=8~%~%int32 offset~%int32 size~%uint8[] value~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UserIO)))
  "Returns full string definition for message of type 'UserIO"
  (cl:format cl:nil "int32 MIN_USERIO_OFFSET=128~%int32 USERIO_ALIGNMENT=8~%~%int32 offset~%int32 size~%uint8[] value~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UserIO>))
  (cl:+ 0
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'value) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UserIO>))
  "Converts a ROS message object to a list"
  (cl:list 'UserIO
    (cl:cons ':offset (offset msg))
    (cl:cons ':size (size msg))
    (cl:cons ':value (value msg))
))
