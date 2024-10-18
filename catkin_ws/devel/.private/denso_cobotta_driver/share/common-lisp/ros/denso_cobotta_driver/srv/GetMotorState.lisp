; Auto-generated. Do not edit!


(cl:in-package denso_cobotta_driver-srv)


;//! \htmlinclude GetMotorState-request.msg.html

(cl:defclass <GetMotorState-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass GetMotorState-request (<GetMotorState-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetMotorState-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetMotorState-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<GetMotorState-request> is deprecated: use denso_cobotta_driver-srv:GetMotorState-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetMotorState-request>) ostream)
  "Serializes a message object of type '<GetMotorState-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetMotorState-request>) istream)
  "Deserializes a message object of type '<GetMotorState-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetMotorState-request>)))
  "Returns string type for a service object of type '<GetMotorState-request>"
  "denso_cobotta_driver/GetMotorStateRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetMotorState-request)))
  "Returns string type for a service object of type 'GetMotorState-request"
  "denso_cobotta_driver/GetMotorStateRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetMotorState-request>)))
  "Returns md5sum for a message object of type '<GetMotorState-request>"
  "271f2b21ec71f675bf49eb4b1873d850")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetMotorState-request)))
  "Returns md5sum for a message object of type 'GetMotorState-request"
  "271f2b21ec71f675bf49eb4b1873d850")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetMotorState-request>)))
  "Returns full string definition for message of type '<GetMotorState-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetMotorState-request)))
  "Returns full string definition for message of type 'GetMotorState-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetMotorState-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetMotorState-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetMotorState-request
))
;//! \htmlinclude GetMotorState-response.msg.html

(cl:defclass <GetMotorState-response> (roslisp-msg-protocol:ros-message)
  ((state
    :reader state
    :initarg :state
    :type cl:boolean
    :initform cl:nil)
   (success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass GetMotorState-response (<GetMotorState-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetMotorState-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetMotorState-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<GetMotorState-response> is deprecated: use denso_cobotta_driver-srv:GetMotorState-response instead.")))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <GetMotorState-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:state-val is deprecated.  Use denso_cobotta_driver-srv:state instead.")
  (state m))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <GetMotorState-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:success-val is deprecated.  Use denso_cobotta_driver-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetMotorState-response>) ostream)
  "Serializes a message object of type '<GetMotorState-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'state) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetMotorState-response>) istream)
  "Deserializes a message object of type '<GetMotorState-response>"
    (cl:setf (cl:slot-value msg 'state) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetMotorState-response>)))
  "Returns string type for a service object of type '<GetMotorState-response>"
  "denso_cobotta_driver/GetMotorStateResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetMotorState-response)))
  "Returns string type for a service object of type 'GetMotorState-response"
  "denso_cobotta_driver/GetMotorStateResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetMotorState-response>)))
  "Returns md5sum for a message object of type '<GetMotorState-response>"
  "271f2b21ec71f675bf49eb4b1873d850")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetMotorState-response)))
  "Returns md5sum for a message object of type 'GetMotorState-response"
  "271f2b21ec71f675bf49eb4b1873d850")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetMotorState-response>)))
  "Returns full string definition for message of type '<GetMotorState-response>"
  (cl:format cl:nil "bool state~%bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetMotorState-response)))
  "Returns full string definition for message of type 'GetMotorState-response"
  (cl:format cl:nil "bool state~%bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetMotorState-response>))
  (cl:+ 0
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetMotorState-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetMotorState-response
    (cl:cons ':state (state msg))
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetMotorState)))
  'GetMotorState-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetMotorState)))
  'GetMotorState-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetMotorState)))
  "Returns string type for a service object of type '<GetMotorState>"
  "denso_cobotta_driver/GetMotorState")