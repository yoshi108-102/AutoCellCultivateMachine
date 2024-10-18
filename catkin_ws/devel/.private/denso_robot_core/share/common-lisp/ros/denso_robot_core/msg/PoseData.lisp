; Auto-generated. Do not edit!


(cl:in-package denso_robot_core-msg)


;//! \htmlinclude PoseData.msg.html

(cl:defclass <PoseData> (roslisp-msg-protocol:ros-message)
  ((value
    :reader value
    :initarg :value
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0)
   (pass
    :reader pass
    :initarg :pass
    :type cl:integer
    :initform 0)
   (exjoints
    :reader exjoints
    :initarg :exjoints
    :type denso_robot_core-msg:ExJoints
    :initform (cl:make-instance 'denso_robot_core-msg:ExJoints)))
)

(cl:defclass PoseData (<PoseData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PoseData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PoseData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_robot_core-msg:<PoseData> is deprecated: use denso_robot_core-msg:PoseData instead.")))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <PoseData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:value-val is deprecated.  Use denso_robot_core-msg:value instead.")
  (value m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <PoseData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:type-val is deprecated.  Use denso_robot_core-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'pass-val :lambda-list '(m))
(cl:defmethod pass-val ((m <PoseData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:pass-val is deprecated.  Use denso_robot_core-msg:pass instead.")
  (pass m))

(cl:ensure-generic-function 'exjoints-val :lambda-list '(m))
(cl:defmethod exjoints-val ((m <PoseData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:exjoints-val is deprecated.  Use denso_robot_core-msg:exjoints instead.")
  (exjoints m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PoseData>) ostream)
  "Serializes a message object of type '<PoseData>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'value))
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'pass)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'exjoints) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PoseData>) istream)
  "Deserializes a message object of type '<PoseData>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'value) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'value)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pass) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'exjoints) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PoseData>)))
  "Returns string type for a message object of type '<PoseData>"
  "denso_robot_core/PoseData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PoseData)))
  "Returns string type for a message object of type 'PoseData"
  "denso_robot_core/PoseData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PoseData>)))
  "Returns md5sum for a message object of type '<PoseData>"
  "9b62dc5261dfb262aa32713ca52458d1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PoseData)))
  "Returns md5sum for a message object of type 'PoseData"
  "9b62dc5261dfb262aa32713ca52458d1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PoseData>)))
  "Returns full string definition for message of type '<PoseData>"
  (cl:format cl:nil "float32[] value~%int32     type~%int32     pass~%ExJoints  exjoints~%~%~%================================================================================~%MSG: denso_robot_core/ExJoints~%int32    mode~%Joints[] joints~%~%~%================================================================================~%MSG: denso_robot_core/Joints~%int32   joint~%float64 value~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PoseData)))
  "Returns full string definition for message of type 'PoseData"
  (cl:format cl:nil "float32[] value~%int32     type~%int32     pass~%ExJoints  exjoints~%~%~%================================================================================~%MSG: denso_robot_core/ExJoints~%int32    mode~%Joints[] joints~%~%~%================================================================================~%MSG: denso_robot_core/Joints~%int32   joint~%float64 value~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PoseData>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'value) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'exjoints))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PoseData>))
  "Converts a ROS message object to a list"
  (cl:list 'PoseData
    (cl:cons ':value (value msg))
    (cl:cons ':type (type msg))
    (cl:cons ':pass (pass msg))
    (cl:cons ':exjoints (exjoints msg))
))
