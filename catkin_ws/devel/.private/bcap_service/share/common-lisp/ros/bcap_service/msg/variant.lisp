; Auto-generated. Do not edit!


(cl:in-package bcap_service-msg)


;//! \htmlinclude variant.msg.html

(cl:defclass <variant> (roslisp-msg-protocol:ros-message)
  ((vt
    :reader vt
    :initarg :vt
    :type cl:fixnum
    :initform 0)
   (value
    :reader value
    :initarg :value
    :type cl:string
    :initform ""))
)

(cl:defclass variant (<variant>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <variant>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'variant)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name bcap_service-msg:<variant> is deprecated: use bcap_service-msg:variant instead.")))

(cl:ensure-generic-function 'vt-val :lambda-list '(m))
(cl:defmethod vt-val ((m <variant>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader bcap_service-msg:vt-val is deprecated.  Use bcap_service-msg:vt instead.")
  (vt m))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <variant>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader bcap_service-msg:value-val is deprecated.  Use bcap_service-msg:value instead.")
  (value m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <variant>) ostream)
  "Serializes a message object of type '<variant>"
  (cl:let* ((signed (cl:slot-value msg 'vt)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'value))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <variant>) istream)
  "Deserializes a message object of type '<variant>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'vt) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'value) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'value) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<variant>)))
  "Returns string type for a message object of type '<variant>"
  "bcap_service/variant")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'variant)))
  "Returns string type for a message object of type 'variant"
  "bcap_service/variant")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<variant>)))
  "Returns md5sum for a message object of type '<variant>"
  "0ff385ab5cb58d55d6c7b0d33e88693e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'variant)))
  "Returns md5sum for a message object of type 'variant"
  "0ff385ab5cb58d55d6c7b0d33e88693e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<variant>)))
  "Returns full string definition for message of type '<variant>"
  (cl:format cl:nil "int16 vt~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'variant)))
  "Returns full string definition for message of type 'variant"
  (cl:format cl:nil "int16 vt~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <variant>))
  (cl:+ 0
     2
     4 (cl:length (cl:slot-value msg 'value))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <variant>))
  "Converts a ROS message object to a list"
  (cl:list 'variant
    (cl:cons ':vt (vt msg))
    (cl:cons ':value (value msg))
))
