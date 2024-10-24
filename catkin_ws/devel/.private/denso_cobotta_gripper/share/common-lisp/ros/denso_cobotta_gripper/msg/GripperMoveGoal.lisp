; Auto-generated. Do not edit!


(cl:in-package denso_cobotta_gripper-msg)


;//! \htmlinclude GripperMoveGoal.msg.html

(cl:defclass <GripperMoveGoal> (roslisp-msg-protocol:ros-message)
  ((target_position
    :reader target_position
    :initarg :target_position
    :type cl:float
    :initform 0.0)
   (speed
    :reader speed
    :initarg :speed
    :type cl:float
    :initform 0.0)
   (effort
    :reader effort
    :initarg :effort
    :type cl:float
    :initform 0.0))
)

(cl:defclass GripperMoveGoal (<GripperMoveGoal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GripperMoveGoal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GripperMoveGoal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_gripper-msg:<GripperMoveGoal> is deprecated: use denso_cobotta_gripper-msg:GripperMoveGoal instead.")))

(cl:ensure-generic-function 'target_position-val :lambda-list '(m))
(cl:defmethod target_position-val ((m <GripperMoveGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_gripper-msg:target_position-val is deprecated.  Use denso_cobotta_gripper-msg:target_position instead.")
  (target_position m))

(cl:ensure-generic-function 'speed-val :lambda-list '(m))
(cl:defmethod speed-val ((m <GripperMoveGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_gripper-msg:speed-val is deprecated.  Use denso_cobotta_gripper-msg:speed instead.")
  (speed m))

(cl:ensure-generic-function 'effort-val :lambda-list '(m))
(cl:defmethod effort-val ((m <GripperMoveGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_gripper-msg:effort-val is deprecated.  Use denso_cobotta_gripper-msg:effort instead.")
  (effort m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GripperMoveGoal>) ostream)
  "Serializes a message object of type '<GripperMoveGoal>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'target_position))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speed))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'effort))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GripperMoveGoal>) istream)
  "Deserializes a message object of type '<GripperMoveGoal>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'target_position) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speed) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'effort) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GripperMoveGoal>)))
  "Returns string type for a message object of type '<GripperMoveGoal>"
  "denso_cobotta_gripper/GripperMoveGoal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GripperMoveGoal)))
  "Returns string type for a message object of type 'GripperMoveGoal"
  "denso_cobotta_gripper/GripperMoveGoal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GripperMoveGoal>)))
  "Returns md5sum for a message object of type '<GripperMoveGoal>"
  "991e9685b46a7195c4e7ad3c7b7809ce")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GripperMoveGoal)))
  "Returns md5sum for a message object of type 'GripperMoveGoal"
  "991e9685b46a7195c4e7ad3c7b7809ce")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GripperMoveGoal>)))
  "Returns full string definition for message of type '<GripperMoveGoal>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%float64  target_position~%float32  speed~%float32  effort~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GripperMoveGoal)))
  "Returns full string definition for message of type 'GripperMoveGoal"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%float64  target_position~%float32  speed~%float32  effort~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GripperMoveGoal>))
  (cl:+ 0
     8
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GripperMoveGoal>))
  "Converts a ROS message object to a list"
  (cl:list 'GripperMoveGoal
    (cl:cons ':target_position (target_position msg))
    (cl:cons ':speed (speed msg))
    (cl:cons ':effort (effort msg))
))
