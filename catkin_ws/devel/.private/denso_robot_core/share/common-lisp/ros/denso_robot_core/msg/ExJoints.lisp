; Auto-generated. Do not edit!


(cl:in-package denso_robot_core-msg)


;//! \htmlinclude ExJoints.msg.html

(cl:defclass <ExJoints> (roslisp-msg-protocol:ros-message)
  ((mode
    :reader mode
    :initarg :mode
    :type cl:integer
    :initform 0)
   (joints
    :reader joints
    :initarg :joints
    :type (cl:vector denso_robot_core-msg:Joints)
   :initform (cl:make-array 0 :element-type 'denso_robot_core-msg:Joints :initial-element (cl:make-instance 'denso_robot_core-msg:Joints))))
)

(cl:defclass ExJoints (<ExJoints>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ExJoints>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ExJoints)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_robot_core-msg:<ExJoints> is deprecated: use denso_robot_core-msg:ExJoints instead.")))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <ExJoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:mode-val is deprecated.  Use denso_robot_core-msg:mode instead.")
  (mode m))

(cl:ensure-generic-function 'joints-val :lambda-list '(m))
(cl:defmethod joints-val ((m <ExJoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:joints-val is deprecated.  Use denso_robot_core-msg:joints instead.")
  (joints m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ExJoints>) ostream)
  "Serializes a message object of type '<ExJoints>"
  (cl:let* ((signed (cl:slot-value msg 'mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'joints))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'joints))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ExJoints>) istream)
  "Deserializes a message object of type '<ExJoints>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'joints) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'joints)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'denso_robot_core-msg:Joints))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ExJoints>)))
  "Returns string type for a message object of type '<ExJoints>"
  "denso_robot_core/ExJoints")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExJoints)))
  "Returns string type for a message object of type 'ExJoints"
  "denso_robot_core/ExJoints")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ExJoints>)))
  "Returns md5sum for a message object of type '<ExJoints>"
  "cf76e185e2fbb6a8349fec25c2682163")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ExJoints)))
  "Returns md5sum for a message object of type 'ExJoints"
  "cf76e185e2fbb6a8349fec25c2682163")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ExJoints>)))
  "Returns full string definition for message of type '<ExJoints>"
  (cl:format cl:nil "int32    mode~%Joints[] joints~%~%~%================================================================================~%MSG: denso_robot_core/Joints~%int32   joint~%float64 value~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ExJoints)))
  "Returns full string definition for message of type 'ExJoints"
  (cl:format cl:nil "int32    mode~%Joints[] joints~%~%~%================================================================================~%MSG: denso_robot_core/Joints~%int32   joint~%float64 value~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ExJoints>))
  (cl:+ 0
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'joints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ExJoints>))
  "Converts a ROS message object to a list"
  (cl:list 'ExJoints
    (cl:cons ':mode (mode msg))
    (cl:cons ':joints (joints msg))
))
