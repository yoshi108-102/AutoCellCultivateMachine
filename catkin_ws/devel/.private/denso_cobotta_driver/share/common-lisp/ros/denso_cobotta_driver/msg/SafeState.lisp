; Auto-generated. Do not edit!


(cl:in-package denso_cobotta_driver-msg)


;//! \htmlinclude SafeState.msg.html

(cl:defclass <SafeState> (roslisp-msg-protocol:ros-message)
  ((state_code
    :reader state_code
    :initarg :state_code
    :type cl:integer
    :initform 0)
   (state_subcode
    :reader state_subcode
    :initarg :state_subcode
    :type cl:integer
    :initform 0))
)

(cl:defclass SafeState (<SafeState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SafeState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SafeState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-msg:<SafeState> is deprecated: use denso_cobotta_driver-msg:SafeState instead.")))

(cl:ensure-generic-function 'state_code-val :lambda-list '(m))
(cl:defmethod state_code-val ((m <SafeState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-msg:state_code-val is deprecated.  Use denso_cobotta_driver-msg:state_code instead.")
  (state_code m))

(cl:ensure-generic-function 'state_subcode-val :lambda-list '(m))
(cl:defmethod state_subcode-val ((m <SafeState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-msg:state_subcode-val is deprecated.  Use denso_cobotta_driver-msg:state_subcode instead.")
  (state_subcode m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SafeState>) ostream)
  "Serializes a message object of type '<SafeState>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'state_code)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'state_code)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'state_code)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'state_code)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'state_subcode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'state_subcode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'state_subcode)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'state_subcode)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SafeState>) istream)
  "Deserializes a message object of type '<SafeState>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'state_code)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'state_code)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'state_code)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'state_code)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'state_subcode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'state_subcode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'state_subcode)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'state_subcode)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SafeState>)))
  "Returns string type for a message object of type '<SafeState>"
  "denso_cobotta_driver/SafeState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SafeState)))
  "Returns string type for a message object of type 'SafeState"
  "denso_cobotta_driver/SafeState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SafeState>)))
  "Returns md5sum for a message object of type '<SafeState>"
  "c6778351a17e3634b544e31281fc203a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SafeState)))
  "Returns md5sum for a message object of type 'SafeState"
  "c6778351a17e3634b544e31281fc203a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SafeState>)))
  "Returns full string definition for message of type '<SafeState>"
  (cl:format cl:nil "uint32 state_code~%uint32 state_subcode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SafeState)))
  "Returns full string definition for message of type 'SafeState"
  (cl:format cl:nil "uint32 state_code~%uint32 state_subcode~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SafeState>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SafeState>))
  "Converts a ROS message object to a list"
  (cl:list 'SafeState
    (cl:cons ':state_code (state_code msg))
    (cl:cons ':state_subcode (state_subcode msg))
))
