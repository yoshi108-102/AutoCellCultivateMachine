; Auto-generated. Do not edit!


(cl:in-package denso_cobotta_driver-srv)


;//! \htmlinclude SetMotorState-request.msg.html

(cl:defclass <SetMotorState-request> (roslisp-msg-protocol:ros-message)
  ((state
    :reader state
    :initarg :state
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SetMotorState-request (<SetMotorState-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetMotorState-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetMotorState-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<SetMotorState-request> is deprecated: use denso_cobotta_driver-srv:SetMotorState-request instead.")))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <SetMotorState-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:state-val is deprecated.  Use denso_cobotta_driver-srv:state instead.")
  (state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetMotorState-request>) ostream)
  "Serializes a message object of type '<SetMotorState-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'state) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetMotorState-request>) istream)
  "Deserializes a message object of type '<SetMotorState-request>"
    (cl:setf (cl:slot-value msg 'state) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetMotorState-request>)))
  "Returns string type for a service object of type '<SetMotorState-request>"
  "denso_cobotta_driver/SetMotorStateRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetMotorState-request)))
  "Returns string type for a service object of type 'SetMotorState-request"
  "denso_cobotta_driver/SetMotorStateRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetMotorState-request>)))
  "Returns md5sum for a message object of type '<SetMotorState-request>"
  "4581db74aae4efc6534413a8b210908c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetMotorState-request)))
  "Returns md5sum for a message object of type 'SetMotorState-request"
  "4581db74aae4efc6534413a8b210908c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetMotorState-request>)))
  "Returns full string definition for message of type '<SetMotorState-request>"
  (cl:format cl:nil "bool state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetMotorState-request)))
  "Returns full string definition for message of type 'SetMotorState-request"
  (cl:format cl:nil "bool state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetMotorState-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetMotorState-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetMotorState-request
    (cl:cons ':state (state msg))
))
;//! \htmlinclude SetMotorState-response.msg.html

(cl:defclass <SetMotorState-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SetMotorState-response (<SetMotorState-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetMotorState-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetMotorState-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<SetMotorState-response> is deprecated: use denso_cobotta_driver-srv:SetMotorState-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetMotorState-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:success-val is deprecated.  Use denso_cobotta_driver-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetMotorState-response>) ostream)
  "Serializes a message object of type '<SetMotorState-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetMotorState-response>) istream)
  "Deserializes a message object of type '<SetMotorState-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetMotorState-response>)))
  "Returns string type for a service object of type '<SetMotorState-response>"
  "denso_cobotta_driver/SetMotorStateResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetMotorState-response)))
  "Returns string type for a service object of type 'SetMotorState-response"
  "denso_cobotta_driver/SetMotorStateResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetMotorState-response>)))
  "Returns md5sum for a message object of type '<SetMotorState-response>"
  "4581db74aae4efc6534413a8b210908c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetMotorState-response)))
  "Returns md5sum for a message object of type 'SetMotorState-response"
  "4581db74aae4efc6534413a8b210908c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetMotorState-response>)))
  "Returns full string definition for message of type '<SetMotorState-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetMotorState-response)))
  "Returns full string definition for message of type 'SetMotorState-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetMotorState-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetMotorState-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetMotorState-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetMotorState)))
  'SetMotorState-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetMotorState)))
  'SetMotorState-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetMotorState)))
  "Returns string type for a service object of type '<SetMotorState>"
  "denso_cobotta_driver/SetMotorState")