
(cl:in-package :asdf)

(defsystem "gripper_ntlab_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "CartesianPosition" :depends-on ("_package_CartesianPosition"))
    (:file "_package_CartesianPosition" :depends-on ("_package"))
    (:file "JointPosition" :depends-on ("_package_JointPosition"))
    (:file "_package_JointPosition" :depends-on ("_package"))
  ))