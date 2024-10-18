; Auto-generated. Do not edit!


(cl:in-package denso_cobotta_driver-srv)


;//! \htmlinclude ExecCalset-request.msg.html

(cl:defclass <ExecCalset-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ExecCalset-request (<ExecCalset-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ExecCalset-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ExecCalset-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<ExecCalset-request> is deprecated: use denso_cobotta_driver-srv:ExecCalset-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ExecCalset-request>) ostream)
  "Serializes a message object of type '<ExecCalset-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ExecCalset-request>) istream)
  "Deserializes a message object of type '<ExecCalset-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ExecCalset-request>)))
  "Returns string type for a service object of type '<ExecCalset-request>"
  "denso_cobotta_driver/ExecCalsetRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExecCalset-request)))
  "Returns string type for a service object of type 'ExecCalset-request"
  "denso_cobotta_driver/ExecCalsetRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ExecCalset-request>)))
  "Returns md5sum for a message object of type '<ExecCalset-request>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ExecCalset-request)))
  "Returns md5sum for a message object of type 'ExecCalset-request"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ExecCalset-request>)))
  "Returns full string definition for message of type '<ExecCalset-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ExecCalset-request)))
  "Returns full string definition for message of type 'ExecCalset-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ExecCalset-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ExecCalset-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ExecCalset-request
))
;//! \htmlinclude ExecCalset-response.msg.html

(cl:defclass <ExecCalset-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ExecCalset-response (<ExecCalset-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ExecCalset-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ExecCalset-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<ExecCalset-response> is deprecated: use denso_cobotta_driver-srv:ExecCalset-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <ExecCalset-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:success-val is deprecated.  Use denso_cobotta_driver-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ExecCalset-response>) ostream)
  "Serializes a message object of type '<ExecCalset-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ExecCalset-response>) istream)
  "Deserializes a message object of type '<ExecCalset-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ExecCalset-response>)))
  "Returns string type for a service object of type '<ExecCalset-response>"
  "denso_cobotta_driver/ExecCalsetResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExecCalset-response)))
  "Returns string type for a service object of type 'ExecCalset-response"
  "denso_cobotta_driver/ExecCalsetResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ExecCalset-response>)))
  "Returns md5sum for a message object of type '<ExecCalset-response>"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ExecCalset-response)))
  "Returns md5sum for a message object of type 'ExecCalset-response"
  "358e233cde0c8a8bcfea4ce193f8fc15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ExecCalset-response>)))
  "Returns full string definition for message of type '<ExecCalset-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ExecCalset-response)))
  "Returns full string definition for message of type 'ExecCalset-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ExecCalset-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ExecCalset-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ExecCalset-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ExecCalset)))
  'ExecCalset-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ExecCalset)))
  'ExecCalset-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ExecCalset)))
  "Returns string type for a service object of type '<ExecCalset>"
  "denso_cobotta_driver/ExecCalset")