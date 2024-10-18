; Auto-generated. Do not edit!


(cl:in-package denso_cobotta_driver-srv)


;//! \htmlinclude ClearRobotError-request.msg.html

(cl:defclass <ClearRobotError-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ClearRobotError-request (<ClearRobotError-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ClearRobotError-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ClearRobotError-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<ClearRobotError-request> is deprecated: use denso_cobotta_driver-srv:ClearRobotError-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ClearRobotError-request>) ostream)
  "Serializes a message object of type '<ClearRobotError-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ClearRobotError-request>) istream)
  "Deserializes a message object of type '<ClearRobotError-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ClearRobotError-request>)))
  "Returns string type for a service object of type '<ClearRobotError-request>"
  "denso_cobotta_driver/ClearRobotErrorRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearRobotError-request)))
  "Returns string type for a service object of type 'ClearRobotError-request"
  "denso_cobotta_driver/ClearRobotErrorRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ClearRobotError-request>)))
  "Returns md5sum for a message object of type '<ClearRobotError-request>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ClearRobotError-request)))
  "Returns md5sum for a message object of type 'ClearRobotError-request"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ClearRobotError-request>)))
  "Returns full string definition for message of type '<ClearRobotError-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ClearRobotError-request)))
  "Returns full string definition for message of type 'ClearRobotError-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ClearRobotError-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ClearRobotError-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ClearRobotError-request
))
;//! \htmlinclude ClearRobotError-response.msg.html

(cl:defclass <ClearRobotError-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ClearRobotError-response (<ClearRobotError-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ClearRobotError-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ClearRobotError-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<ClearRobotError-response> is deprecated: use denso_cobotta_driver-srv:ClearRobotError-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <ClearRobotError-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:success-val is deprecated.  Use denso_cobotta_driver-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ClearRobotError-response>) ostream)
  "Serializes a message object of type '<ClearRobotError-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ClearRobotError-response>) istream)
  "Deserializes a message object of type '<ClearRobotError-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ClearRobotError-response>)))
  "Returns string type for a service object of type '<ClearRobotError-response>"
  "denso_cobotta_driver/ClearRobotErrorResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearRobotError-response)))
  "Returns string type for a service object of type 'ClearRobotError-response"
  "denso_cobotta_driver/ClearRobotErrorResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ClearRobotError-response>)))
  "Returns md5sum for a message object of type '<ClearRobotError-response>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ClearRobotError-response)))
  "Returns md5sum for a message object of type 'ClearRobotError-response"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ClearRobotError-response>)))
  "Returns full string definition for message of type '<ClearRobotError-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ClearRobotError-response)))
  "Returns full string definition for message of type 'ClearRobotError-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ClearRobotError-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ClearRobotError-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ClearRobotError-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ClearRobotError)))
  'ClearRobotError-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ClearRobotError)))
  'ClearRobotError-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearRobotError)))
  "Returns string type for a service object of type '<ClearRobotError>"
  "denso_cobotta_driver/ClearRobotError")