; Auto-generated. Do not edit!


(cl:in-package denso_cobotta_driver-srv)


;//! \htmlinclude ClearSafeState-request.msg.html

(cl:defclass <ClearSafeState-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ClearSafeState-request (<ClearSafeState-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ClearSafeState-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ClearSafeState-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<ClearSafeState-request> is deprecated: use denso_cobotta_driver-srv:ClearSafeState-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ClearSafeState-request>) ostream)
  "Serializes a message object of type '<ClearSafeState-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ClearSafeState-request>) istream)
  "Deserializes a message object of type '<ClearSafeState-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ClearSafeState-request>)))
  "Returns string type for a service object of type '<ClearSafeState-request>"
  "denso_cobotta_driver/ClearSafeStateRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearSafeState-request)))
  "Returns string type for a service object of type 'ClearSafeState-request"
  "denso_cobotta_driver/ClearSafeStateRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ClearSafeState-request>)))
  "Returns md5sum for a message object of type '<ClearSafeState-request>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ClearSafeState-request)))
  "Returns md5sum for a message object of type 'ClearSafeState-request"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ClearSafeState-request>)))
  "Returns full string definition for message of type '<ClearSafeState-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ClearSafeState-request)))
  "Returns full string definition for message of type 'ClearSafeState-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ClearSafeState-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ClearSafeState-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ClearSafeState-request
))
;//! \htmlinclude ClearSafeState-response.msg.html

(cl:defclass <ClearSafeState-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ClearSafeState-response (<ClearSafeState-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ClearSafeState-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ClearSafeState-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<ClearSafeState-response> is deprecated: use denso_cobotta_driver-srv:ClearSafeState-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <ClearSafeState-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:success-val is deprecated.  Use denso_cobotta_driver-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ClearSafeState-response>) ostream)
  "Serializes a message object of type '<ClearSafeState-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ClearSafeState-response>) istream)
  "Deserializes a message object of type '<ClearSafeState-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ClearSafeState-response>)))
  "Returns string type for a service object of type '<ClearSafeState-response>"
  "denso_cobotta_driver/ClearSafeStateResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearSafeState-response)))
  "Returns string type for a service object of type 'ClearSafeState-response"
  "denso_cobotta_driver/ClearSafeStateResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ClearSafeState-response>)))
  "Returns md5sum for a message object of type '<ClearSafeState-response>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ClearSafeState-response)))
  "Returns md5sum for a message object of type 'ClearSafeState-response"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ClearSafeState-response>)))
  "Returns full string definition for message of type '<ClearSafeState-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ClearSafeState-response)))
  "Returns full string definition for message of type 'ClearSafeState-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ClearSafeState-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ClearSafeState-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ClearSafeState-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ClearSafeState)))
  'ClearSafeState-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ClearSafeState)))
  'ClearSafeState-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ClearSafeState)))
  "Returns string type for a service object of type '<ClearSafeState>"
  "denso_cobotta_driver/ClearSafeState")