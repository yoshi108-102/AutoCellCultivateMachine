; Auto-generated. Do not edit!


(cl:in-package denso_cobotta_driver-srv)


;//! \htmlinclude GetBrakeState-request.msg.html

(cl:defclass <GetBrakeState-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass GetBrakeState-request (<GetBrakeState-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetBrakeState-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetBrakeState-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<GetBrakeState-request> is deprecated: use denso_cobotta_driver-srv:GetBrakeState-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetBrakeState-request>) ostream)
  "Serializes a message object of type '<GetBrakeState-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetBrakeState-request>) istream)
  "Deserializes a message object of type '<GetBrakeState-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetBrakeState-request>)))
  "Returns string type for a service object of type '<GetBrakeState-request>"
  "denso_cobotta_driver/GetBrakeStateRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetBrakeState-request)))
  "Returns string type for a service object of type 'GetBrakeState-request"
  "denso_cobotta_driver/GetBrakeStateRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetBrakeState-request>)))
  "Returns md5sum for a message object of type '<GetBrakeState-request>"
  "aafd640535ae055e319908df5e1e05da")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetBrakeState-request)))
  "Returns md5sum for a message object of type 'GetBrakeState-request"
  "aafd640535ae055e319908df5e1e05da")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetBrakeState-request>)))
  "Returns full string definition for message of type '<GetBrakeState-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetBrakeState-request)))
  "Returns full string definition for message of type 'GetBrakeState-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetBrakeState-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetBrakeState-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetBrakeState-request
))
;//! \htmlinclude GetBrakeState-response.msg.html

(cl:defclass <GetBrakeState-response> (roslisp-msg-protocol:ros-message)
  ((state
    :reader state
    :initarg :state
    :type (cl:vector cl:boolean)
   :initform (cl:make-array 0 :element-type 'cl:boolean :initial-element cl:nil))
   (success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass GetBrakeState-response (<GetBrakeState-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetBrakeState-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetBrakeState-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<GetBrakeState-response> is deprecated: use denso_cobotta_driver-srv:GetBrakeState-response instead.")))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <GetBrakeState-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:state-val is deprecated.  Use denso_cobotta_driver-srv:state instead.")
  (state m))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <GetBrakeState-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:success-val is deprecated.  Use denso_cobotta_driver-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetBrakeState-response>) ostream)
  "Serializes a message object of type '<GetBrakeState-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'state))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if ele 1 0)) ostream))
   (cl:slot-value msg 'state))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetBrakeState-response>) istream)
  "Deserializes a message object of type '<GetBrakeState-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'state) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'state)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:not (cl:zerop (cl:read-byte istream)))))))
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetBrakeState-response>)))
  "Returns string type for a service object of type '<GetBrakeState-response>"
  "denso_cobotta_driver/GetBrakeStateResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetBrakeState-response)))
  "Returns string type for a service object of type 'GetBrakeState-response"
  "denso_cobotta_driver/GetBrakeStateResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetBrakeState-response>)))
  "Returns md5sum for a message object of type '<GetBrakeState-response>"
  "aafd640535ae055e319908df5e1e05da")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetBrakeState-response)))
  "Returns md5sum for a message object of type 'GetBrakeState-response"
  "aafd640535ae055e319908df5e1e05da")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetBrakeState-response>)))
  "Returns full string definition for message of type '<GetBrakeState-response>"
  (cl:format cl:nil "bool[] state~%bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetBrakeState-response)))
  "Returns full string definition for message of type 'GetBrakeState-response"
  (cl:format cl:nil "bool[] state~%bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetBrakeState-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'state) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetBrakeState-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetBrakeState-response
    (cl:cons ':state (state msg))
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetBrakeState)))
  'GetBrakeState-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetBrakeState)))
  'GetBrakeState-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetBrakeState)))
  "Returns string type for a service object of type '<GetBrakeState>"
  "denso_cobotta_driver/GetBrakeState")