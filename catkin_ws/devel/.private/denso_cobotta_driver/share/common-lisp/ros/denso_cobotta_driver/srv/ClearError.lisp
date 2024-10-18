; Auto-generated. Do not edit!


(cl:in-package denso_cobotta_driver-srv)


;//! \htmlinclude ClearError-request.msg.html

(cl:defclass <ClearError-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ClearError-request (<ClearError-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ClearError-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ClearError-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<ClearError-request> is deprecated: use denso_cobotta_driver-srv:ClearError-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ClearError-request>) ostream)
  "Serializes a message object of type '<ClearError-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ClearError-request>) istream)
  "Deserializes a message object of type '<ClearError-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ClearError-request>)))
  "Returns string type for a service object of type '<ClearError-request>"
  "denso_cobotta_driver/ClearErrorRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearError-request)))
  "Returns string type for a service object of type 'ClearError-request"
  "denso_cobotta_driver/ClearErrorRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ClearError-request>)))
  "Returns md5sum for a message object of type '<ClearError-request>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ClearError-request)))
  "Returns md5sum for a message object of type 'ClearError-request"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ClearError-request>)))
  "Returns full string definition for message of type '<ClearError-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ClearError-request)))
  "Returns full string definition for message of type 'ClearError-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ClearError-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ClearError-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ClearError-request
))
;//! \htmlinclude ClearError-response.msg.html

(cl:defclass <ClearError-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ClearError-response (<ClearError-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ClearError-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ClearError-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<ClearError-response> is deprecated: use denso_cobotta_driver-srv:ClearError-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <ClearError-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:success-val is deprecated.  Use denso_cobotta_driver-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ClearError-response>) ostream)
  "Serializes a message object of type '<ClearError-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ClearError-response>) istream)
  "Deserializes a message object of type '<ClearError-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ClearError-response>)))
  "Returns string type for a service object of type '<ClearError-response>"
  "denso_cobotta_driver/ClearErrorResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearError-response)))
  "Returns string type for a service object of type 'ClearError-response"
  "denso_cobotta_driver/ClearErrorResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ClearError-response>)))
  "Returns md5sum for a message object of type '<ClearError-response>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ClearError-response)))
  "Returns md5sum for a message object of type 'ClearError-response"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ClearError-response>)))
  "Returns full string definition for message of type '<ClearError-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ClearError-response)))
  "Returns full string definition for message of type 'ClearError-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ClearError-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ClearError-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ClearError-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ClearError)))
  'ClearError-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ClearError)))
  'ClearError-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearError)))
  "Returns string type for a service object of type '<ClearError>"
  "denso_cobotta_driver/ClearError")