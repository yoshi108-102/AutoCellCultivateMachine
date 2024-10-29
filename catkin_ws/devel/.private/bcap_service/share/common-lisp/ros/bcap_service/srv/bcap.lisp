; Auto-generated. Do not edit!


(cl:in-package bcap_service-srv)


;//! \htmlinclude bcap-request.msg.html

(cl:defclass <bcap-request> (roslisp-msg-protocol:ros-message)
  ((func_id
    :reader func_id
    :initarg :func_id
    :type cl:integer
    :initform 0)
   (vntArgs
    :reader vntArgs
    :initarg :vntArgs
    :type (cl:vector bcap_service-msg:variant)
   :initform (cl:make-array 0 :element-type 'bcap_service-msg:variant :initial-element (cl:make-instance 'bcap_service-msg:variant))))
)

(cl:defclass bcap-request (<bcap-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <bcap-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'bcap-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name bcap_service-srv:<bcap-request> is deprecated: use bcap_service-srv:bcap-request instead.")))

(cl:ensure-generic-function 'func_id-val :lambda-list '(m))
(cl:defmethod func_id-val ((m <bcap-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader bcap_service-srv:func_id-val is deprecated.  Use bcap_service-srv:func_id instead.")
  (func_id m))

(cl:ensure-generic-function 'vntArgs-val :lambda-list '(m))
(cl:defmethod vntArgs-val ((m <bcap-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader bcap_service-srv:vntArgs-val is deprecated.  Use bcap_service-srv:vntArgs instead.")
  (vntArgs m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <bcap-request>) ostream)
  "Serializes a message object of type '<bcap-request>"
  (cl:let* ((signed (cl:slot-value msg 'func_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'vntArgs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'vntArgs))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <bcap-request>) istream)
  "Deserializes a message object of type '<bcap-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'func_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'vntArgs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'vntArgs)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'bcap_service-msg:variant))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<bcap-request>)))
  "Returns string type for a service object of type '<bcap-request>"
  "bcap_service/bcapRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'bcap-request)))
  "Returns string type for a service object of type 'bcap-request"
  "bcap_service/bcapRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<bcap-request>)))
  "Returns md5sum for a message object of type '<bcap-request>"
  "d7da50225be5d246d6e3baaab811da16")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'bcap-request)))
  "Returns md5sum for a message object of type 'bcap-request"
  "d7da50225be5d246d6e3baaab811da16")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<bcap-request>)))
  "Returns full string definition for message of type '<bcap-request>"
  (cl:format cl:nil "int32 func_id~%variant[] vntArgs~%~%================================================================================~%MSG: bcap_service/variant~%int16 vt~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'bcap-request)))
  "Returns full string definition for message of type 'bcap-request"
  (cl:format cl:nil "int32 func_id~%variant[] vntArgs~%~%================================================================================~%MSG: bcap_service/variant~%int16 vt~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <bcap-request>))
  (cl:+ 0
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'vntArgs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <bcap-request>))
  "Converts a ROS message object to a list"
  (cl:list 'bcap-request
    (cl:cons ':func_id (func_id msg))
    (cl:cons ':vntArgs (vntArgs msg))
))
;//! \htmlinclude bcap-response.msg.html

(cl:defclass <bcap-response> (roslisp-msg-protocol:ros-message)
  ((HRESULT
    :reader HRESULT
    :initarg :HRESULT
    :type cl:integer
    :initform 0)
   (vntRet
    :reader vntRet
    :initarg :vntRet
    :type bcap_service-msg:variant
    :initform (cl:make-instance 'bcap_service-msg:variant)))
)

(cl:defclass bcap-response (<bcap-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <bcap-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'bcap-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name bcap_service-srv:<bcap-response> is deprecated: use bcap_service-srv:bcap-response instead.")))

(cl:ensure-generic-function 'HRESULT-val :lambda-list '(m))
(cl:defmethod HRESULT-val ((m <bcap-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader bcap_service-srv:HRESULT-val is deprecated.  Use bcap_service-srv:HRESULT instead.")
  (HRESULT m))

(cl:ensure-generic-function 'vntRet-val :lambda-list '(m))
(cl:defmethod vntRet-val ((m <bcap-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader bcap_service-srv:vntRet-val is deprecated.  Use bcap_service-srv:vntRet instead.")
  (vntRet m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <bcap-response>) ostream)
  "Serializes a message object of type '<bcap-response>"
  (cl:let* ((signed (cl:slot-value msg 'HRESULT)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'vntRet) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <bcap-response>) istream)
  "Deserializes a message object of type '<bcap-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'HRESULT) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'vntRet) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<bcap-response>)))
  "Returns string type for a service object of type '<bcap-response>"
  "bcap_service/bcapResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'bcap-response)))
  "Returns string type for a service object of type 'bcap-response"
  "bcap_service/bcapResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<bcap-response>)))
  "Returns md5sum for a message object of type '<bcap-response>"
  "d7da50225be5d246d6e3baaab811da16")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'bcap-response)))
  "Returns md5sum for a message object of type 'bcap-response"
  "d7da50225be5d246d6e3baaab811da16")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<bcap-response>)))
  "Returns full string definition for message of type '<bcap-response>"
  (cl:format cl:nil "int32 HRESULT~%variant vntRet~%~%================================================================================~%MSG: bcap_service/variant~%int16 vt~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'bcap-response)))
  "Returns full string definition for message of type 'bcap-response"
  (cl:format cl:nil "int32 HRESULT~%variant vntRet~%~%================================================================================~%MSG: bcap_service/variant~%int16 vt~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <bcap-response>))
  (cl:+ 0
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'vntRet))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <bcap-response>))
  "Converts a ROS message object to a list"
  (cl:list 'bcap-response
    (cl:cons ':HRESULT (HRESULT msg))
    (cl:cons ':vntRet (vntRet msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'bcap)))
  'bcap-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'bcap)))
  'bcap-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'bcap)))
  "Returns string type for a service object of type '<bcap>"
  "bcap_service/bcap")