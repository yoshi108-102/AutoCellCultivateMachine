; Auto-generated. Do not edit!


(cl:in-package denso_cobotta_driver-srv)


;//! \htmlinclude SetBrakeState-request.msg.html

(cl:defclass <SetBrakeState-request> (roslisp-msg-protocol:ros-message)
  ((state
    :reader state
    :initarg :state
    :type (cl:vector cl:boolean)
   :initform (cl:make-array 0 :element-type 'cl:boolean :initial-element cl:nil)))
)

(cl:defclass SetBrakeState-request (<SetBrakeState-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetBrakeState-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetBrakeState-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<SetBrakeState-request> is deprecated: use denso_cobotta_driver-srv:SetBrakeState-request instead.")))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <SetBrakeState-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:state-val is deprecated.  Use denso_cobotta_driver-srv:state instead.")
  (state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetBrakeState-request>) ostream)
  "Serializes a message object of type '<SetBrakeState-request>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'state))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if ele 1 0)) ostream))
   (cl:slot-value msg 'state))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetBrakeState-request>) istream)
  "Deserializes a message object of type '<SetBrakeState-request>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'state) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'state)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:not (cl:zerop (cl:read-byte istream)))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetBrakeState-request>)))
  "Returns string type for a service object of type '<SetBrakeState-request>"
  "denso_cobotta_driver/SetBrakeStateRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetBrakeState-request)))
  "Returns string type for a service object of type 'SetBrakeState-request"
  "denso_cobotta_driver/SetBrakeStateRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetBrakeState-request>)))
  "Returns md5sum for a message object of type '<SetBrakeState-request>"
  "ae7dda53a675ec4b8a49daeadb776d4c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetBrakeState-request)))
  "Returns md5sum for a message object of type 'SetBrakeState-request"
  "ae7dda53a675ec4b8a49daeadb776d4c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetBrakeState-request>)))
  "Returns full string definition for message of type '<SetBrakeState-request>"
  (cl:format cl:nil "bool[] state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetBrakeState-request)))
  "Returns full string definition for message of type 'SetBrakeState-request"
  (cl:format cl:nil "bool[] state~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetBrakeState-request>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'state) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetBrakeState-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetBrakeState-request
    (cl:cons ':state (state msg))
))
;//! \htmlinclude SetBrakeState-response.msg.html

(cl:defclass <SetBrakeState-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SetBrakeState-response (<SetBrakeState-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetBrakeState-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetBrakeState-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<SetBrakeState-response> is deprecated: use denso_cobotta_driver-srv:SetBrakeState-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetBrakeState-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:success-val is deprecated.  Use denso_cobotta_driver-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetBrakeState-response>) ostream)
  "Serializes a message object of type '<SetBrakeState-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetBrakeState-response>) istream)
  "Deserializes a message object of type '<SetBrakeState-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetBrakeState-response>)))
  "Returns string type for a service object of type '<SetBrakeState-response>"
  "denso_cobotta_driver/SetBrakeStateResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetBrakeState-response)))
  "Returns string type for a service object of type 'SetBrakeState-response"
  "denso_cobotta_driver/SetBrakeStateResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetBrakeState-response>)))
  "Returns md5sum for a message object of type '<SetBrakeState-response>"
  "ae7dda53a675ec4b8a49daeadb776d4c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetBrakeState-response)))
  "Returns md5sum for a message object of type 'SetBrakeState-response"
  "ae7dda53a675ec4b8a49daeadb776d4c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetBrakeState-response>)))
  "Returns full string definition for message of type '<SetBrakeState-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetBrakeState-response)))
  "Returns full string definition for message of type 'SetBrakeState-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetBrakeState-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetBrakeState-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetBrakeState-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetBrakeState)))
  'SetBrakeState-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetBrakeState)))
  'SetBrakeState-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetBrakeState)))
  "Returns string type for a service object of type '<SetBrakeState>"
  "denso_cobotta_driver/SetBrakeState")