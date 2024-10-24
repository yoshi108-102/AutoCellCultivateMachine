; Auto-generated. Do not edit!


(cl:in-package denso_cobotta_driver-srv)


;//! \htmlinclude SetLEDState-request.msg.html

(cl:defclass <SetLEDState-request> (roslisp-msg-protocol:ros-message)
  ((red
    :reader red
    :initarg :red
    :type cl:fixnum
    :initform 0)
   (green
    :reader green
    :initarg :green
    :type cl:fixnum
    :initform 0)
   (blue
    :reader blue
    :initarg :blue
    :type cl:fixnum
    :initform 0)
   (blink_rate
    :reader blink_rate
    :initarg :blink_rate
    :type cl:fixnum
    :initform 0))
)

(cl:defclass SetLEDState-request (<SetLEDState-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetLEDState-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetLEDState-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<SetLEDState-request> is deprecated: use denso_cobotta_driver-srv:SetLEDState-request instead.")))

(cl:ensure-generic-function 'red-val :lambda-list '(m))
(cl:defmethod red-val ((m <SetLEDState-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:red-val is deprecated.  Use denso_cobotta_driver-srv:red instead.")
  (red m))

(cl:ensure-generic-function 'green-val :lambda-list '(m))
(cl:defmethod green-val ((m <SetLEDState-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:green-val is deprecated.  Use denso_cobotta_driver-srv:green instead.")
  (green m))

(cl:ensure-generic-function 'blue-val :lambda-list '(m))
(cl:defmethod blue-val ((m <SetLEDState-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:blue-val is deprecated.  Use denso_cobotta_driver-srv:blue instead.")
  (blue m))

(cl:ensure-generic-function 'blink_rate-val :lambda-list '(m))
(cl:defmethod blink_rate-val ((m <SetLEDState-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:blink_rate-val is deprecated.  Use denso_cobotta_driver-srv:blink_rate instead.")
  (blink_rate m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetLEDState-request>) ostream)
  "Serializes a message object of type '<SetLEDState-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'red)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'green)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'blue)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'blink_rate)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetLEDState-request>) istream)
  "Deserializes a message object of type '<SetLEDState-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'red)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'green)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'blue)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'blink_rate)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetLEDState-request>)))
  "Returns string type for a service object of type '<SetLEDState-request>"
  "denso_cobotta_driver/SetLEDStateRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetLEDState-request)))
  "Returns string type for a service object of type 'SetLEDState-request"
  "denso_cobotta_driver/SetLEDStateRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetLEDState-request>)))
  "Returns md5sum for a message object of type '<SetLEDState-request>"
  "2ae38ea1f2419ff3e6383563a0531fc9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetLEDState-request)))
  "Returns md5sum for a message object of type 'SetLEDState-request"
  "2ae38ea1f2419ff3e6383563a0531fc9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetLEDState-request>)))
  "Returns full string definition for message of type '<SetLEDState-request>"
  (cl:format cl:nil "uint8 red~%uint8 green~%uint8 blue~%uint8 blink_rate~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetLEDState-request)))
  "Returns full string definition for message of type 'SetLEDState-request"
  (cl:format cl:nil "uint8 red~%uint8 green~%uint8 blue~%uint8 blink_rate~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetLEDState-request>))
  (cl:+ 0
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetLEDState-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SetLEDState-request
    (cl:cons ':red (red msg))
    (cl:cons ':green (green msg))
    (cl:cons ':blue (blue msg))
    (cl:cons ':blink_rate (blink_rate msg))
))
;//! \htmlinclude SetLEDState-response.msg.html

(cl:defclass <SetLEDState-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SetLEDState-response (<SetLEDState-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetLEDState-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetLEDState-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name denso_cobotta_driver-srv:<SetLEDState-response> is deprecated: use denso_cobotta_driver-srv:SetLEDState-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SetLEDState-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader denso_cobotta_driver-srv:success-val is deprecated.  Use denso_cobotta_driver-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetLEDState-response>) ostream)
  "Serializes a message object of type '<SetLEDState-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetLEDState-response>) istream)
  "Deserializes a message object of type '<SetLEDState-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetLEDState-response>)))
  "Returns string type for a service object of type '<SetLEDState-response>"
  "denso_cobotta_driver/SetLEDStateResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetLEDState-response)))
  "Returns string type for a service object of type 'SetLEDState-response"
  "denso_cobotta_driver/SetLEDStateResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetLEDState-response>)))
  "Returns md5sum for a message object of type '<SetLEDState-response>"
  "2ae38ea1f2419ff3e6383563a0531fc9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetLEDState-response)))
  "Returns md5sum for a message object of type 'SetLEDState-response"
  "2ae38ea1f2419ff3e6383563a0531fc9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetLEDState-response>)))
  "Returns full string definition for message of type '<SetLEDState-response>"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetLEDState-response)))
  "Returns full string definition for message of type 'SetLEDState-response"
  (cl:format cl:nil "bool success~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetLEDState-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetLEDState-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SetLEDState-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SetLEDState)))
  'SetLEDState-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SetLEDState)))
  'SetLEDState-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetLEDState)))
  "Returns string type for a service object of type '<SetLEDState>"
  "denso_cobotta_driver/SetLEDState")