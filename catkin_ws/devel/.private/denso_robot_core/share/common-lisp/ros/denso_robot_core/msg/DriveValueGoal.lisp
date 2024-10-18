; Auto-generated. Do not edit!


(cl:in-package denso_robot_core-msg)


;//! \htmlinclude DriveValueGoal.msg.html

(cl:defclass <DriveValueGoal> (roslisp-msg-protocol:ros-message)
  ((pose
    :reader pose
    :initarg :pose
    :type (cl:vector denso_robot_core-msg:Joints)
   :initform (cl:make-array 0 :element-type 'denso_robot_core-msg:Joints :initial-element (cl:make-instance 'denso_robot_core-msg:Joints)))
   (pass
    :reader pass
    :initarg :pass
    :type cl:integer
    :initform 0)
   (option
    :reader option
    :initarg :option
    :type cl:string
    :initform ""))
)

(cl:defclass DriveValueGoal (<DriveValueGoal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DriveValueGoal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DriveValueGoal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_robot_core-msg:<DriveValueGoal> is deprecated: use denso_robot_core-msg:DriveValueGoal instead.")))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <DriveValueGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:pose-val is deprecated.  Use denso_robot_core-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'pass-val :lambda-list '(m))
(cl:defmethod pass-val ((m <DriveValueGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:pass-val is deprecated.  Use denso_robot_core-msg:pass instead.")
  (pass m))

(cl:ensure-generic-function 'option-val :lambda-list '(m))
(cl:defmethod option-val ((m <DriveValueGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:option-val is deprecated.  Use denso_robot_core-msg:option instead.")
  (option m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DriveValueGoal>) ostream)
  "Serializes a message object of type '<DriveValueGoal>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'pose))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'pose))
  (cl:let* ((signed (cl:slot-value msg 'pass)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'option))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'option))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DriveValueGoal>) istream)
  "Deserializes a message object of type '<DriveValueGoal>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'pose) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'pose)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'denso_robot_core-msg:Joints))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pass) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'option) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'option) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DriveValueGoal>)))
  "Returns string type for a message object of type '<DriveValueGoal>"
  "denso_robot_core/DriveValueGoal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DriveValueGoal)))
  "Returns string type for a message object of type 'DriveValueGoal"
  "denso_robot_core/DriveValueGoal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DriveValueGoal>)))
  "Returns md5sum for a message object of type '<DriveValueGoal>"
  "52550839b00a7359fb2ca9004e5bc7c2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DriveValueGoal)))
  "Returns md5sum for a message object of type 'DriveValueGoal"
  "52550839b00a7359fb2ca9004e5bc7c2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DriveValueGoal>)))
  "Returns full string definition for message of type '<DriveValueGoal>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%Joints[] pose~%int32    pass~%string   option~%~%================================================================================~%MSG: denso_robot_core/Joints~%int32   joint~%float64 value~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DriveValueGoal)))
  "Returns full string definition for message of type 'DriveValueGoal"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%Joints[] pose~%int32    pass~%string   option~%~%================================================================================~%MSG: denso_robot_core/Joints~%int32   joint~%float64 value~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DriveValueGoal>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'pose) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
     4 (cl:length (cl:slot-value msg 'option))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DriveValueGoal>))
  "Converts a ROS message object to a list"
  (cl:list 'DriveValueGoal
    (cl:cons ':pose (pose msg))
    (cl:cons ':pass (pass msg))
    (cl:cons ':option (option msg))
))
