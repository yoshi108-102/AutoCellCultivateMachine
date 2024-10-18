; Auto-generated. Do not edit!


(cl:in-package denso_robot_core-msg)


;//! \htmlinclude MoveStringGoal.msg.html

(cl:defclass <MoveStringGoal> (roslisp-msg-protocol:ros-message)
  ((comp
    :reader comp
    :initarg :comp
    :type cl:integer
    :initform 0)
   (pose
    :reader pose
    :initarg :pose
    :type cl:string
    :initform "")
   (option
    :reader option
    :initarg :option
    :type cl:string
    :initform ""))
)

(cl:defclass MoveStringGoal (<MoveStringGoal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MoveStringGoal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MoveStringGoal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_robot_core-msg:<MoveStringGoal> is deprecated: use denso_robot_core-msg:MoveStringGoal instead.")))

(cl:ensure-generic-function 'comp-val :lambda-list '(m))
(cl:defmethod comp-val ((m <MoveStringGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:comp-val is deprecated.  Use denso_robot_core-msg:comp instead.")
  (comp m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <MoveStringGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:pose-val is deprecated.  Use denso_robot_core-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'option-val :lambda-list '(m))
(cl:defmethod option-val ((m <MoveStringGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_robot_core-msg:option-val is deprecated.  Use denso_robot_core-msg:option instead.")
  (option m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MoveStringGoal>) ostream)
  "Serializes a message object of type '<MoveStringGoal>"
  (cl:let* ((signed (cl:slot-value msg 'comp)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'pose))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'pose))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'option))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'option))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MoveStringGoal>) istream)
  "Deserializes a message object of type '<MoveStringGoal>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'comp) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pose) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'pose) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MoveStringGoal>)))
  "Returns string type for a message object of type '<MoveStringGoal>"
  "denso_robot_core/MoveStringGoal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MoveStringGoal)))
  "Returns string type for a message object of type 'MoveStringGoal"
  "denso_robot_core/MoveStringGoal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MoveStringGoal>)))
  "Returns md5sum for a message object of type '<MoveStringGoal>"
  "b7823e2161908d80035b12b37a1e31c2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MoveStringGoal)))
  "Returns md5sum for a message object of type 'MoveStringGoal"
  "b7823e2161908d80035b12b37a1e31c2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MoveStringGoal>)))
  "Returns full string definition for message of type '<MoveStringGoal>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%int32  comp~%string pose~%string option~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MoveStringGoal)))
  "Returns full string definition for message of type 'MoveStringGoal"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%int32  comp~%string pose~%string option~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MoveStringGoal>))
  (cl:+ 0
     4
     4 (cl:length (cl:slot-value msg 'pose))
     4 (cl:length (cl:slot-value msg 'option))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MoveStringGoal>))
  "Converts a ROS message object to a list"
  (cl:list 'MoveStringGoal
    (cl:cons ':comp (comp msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':option (option msg))
))
